//
//  HttpRequstTool.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "HttpRequstTool.h"
#import "NMBaseEntity.h"
#import "OrderedDictionary.h"
#import "MD5.h"
#import <AFURLRequestSerialization.h>
static AFHTTPSessionManager *requestOperationManager;

@implementation HttpRequstTool
+ (void)cancelAllRequest {
    [[self getHttpRequestManager].operationQueue cancelAllOperations];
}

+ (AFHTTPSessionManager *)getHttpRequestManager {
   
    if (!requestOperationManager) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        requestOperationManager = manager;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                             @"application/json",
                                                             @"text/plain",
                                                             @"text/json",
                                                             @"text/javascript",
                                                             @"text/html", nil];
        [manager.requestSerializer willChangeValueForKey:@"timeoutIntetval"];
        manager.requestSerializer.timeoutInterval = TIMEOUT;
        [manager.requestSerializer didChangeValueForKey:@"timeoutIntetval"];
        [manager.operationQueue cancelAllOperations];
    }
    return requestOperationManager;
}



+ (UInt64 )longLongFromDate {
    return (UInt64)[[NSDate date] timeIntervalSince1970] * 1000;
}


+ (NSMutableDictionary *)createGeneralParamDic {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"system_name"] = @"1.0.0";
    paramDic[@"time"] = @([self longLongFromDate]); // 当前时间
    paramDic[@"type"] = @"ios"; // 手机类型
   
    return paramDic;
}


+ (void)httpRequestForGet:(NSString *)requestUrl
               parameters:(NSMutableDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    [parameters addEntriesFromDictionary:[self createGeneralParamDic]];
    parameters[@"sign"] = [self createSginCodeWithParamDictionary:parameters];
    [[self getHttpRequestManager] GET:[NSString stringWithFormat:@"%@%@", BaseApiUrl, requestUrl] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *requestError = [NSError errorWithDomain:@"请求失败" code:-1 userInfo:nil];
        if (failure) failure(requestError);
    }];

    
}
+ (NSString *)publicParameterStringWithParameter:(NSDictionary *)parameters andUrl:(NSString *)requestUrl {

    NSEnumerator * enumeratorKey = [parameters keyEnumerator];
    NSMutableString *parametersUrl = [NSMutableString string];
    [parametersUrl appendString:[NSString stringWithFormat:@"%@%@", BaseApiUrl, requestUrl]];
    [parametersUrl appendString:@"?"];
    for (NSString *object in enumeratorKey) {
        [parametersUrl appendString:object];
        [parametersUrl appendString:@"="];
        [parametersUrl appendString:[NSString stringWithFormat:@"%@",parameters[object]]];
        [parametersUrl appendString:@"&"];
    }
    return [parametersUrl substringToIndex:parametersUrl.length -1];
}
+ (void)httpRequestForPost:(NSString *)requestUrl
                parameters:(NSMutableDictionary *)parameters
                   modules:(NSString *)modules
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure {
    // 获取公共参数
    NSMutableDictionary *createGeneralParamDictionary = [self createGeneralParamDic];
  
    // 重新创建一个字典包含post参数
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
   
    // 添加公共参数到新字典
    [dictionary addEntriesFromDictionary:[self createGeneralParamDic]];
    // 生成sign值，添加到公共参数里面
    createGeneralParamDictionary[@"sign"] = [self createSginCodeWithParamDictionary:dictionary];
    // 把公共参数添加到url后面，
    // POST参数里面不带有公共参数
    
    [[self getHttpRequestManager] POST:[HttpRequstTool publicParameterStringWithParameter:createGeneralParamDictionary andUrl:requestUrl] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSError *requestError = [NSError errorWithDomain:@"请求失败" code:-1 userInfo:nil];
        if (failure) failure(requestError);
    }];

}

+ (NSString *)createSginCodeWithParamDictionary:(NSMutableDictionary *)paramDic {
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:paramDic.allKeys];
    [keyArray sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2];
    }];
    OrderedDictionary *orderedDic = [[OrderedDictionary alloc] initWithCapacity:20];
    for (NSString *key in keyArray) {
        // 构造参数URL的时候不传时间Time
        if ([key isEqualToString:@"time"]) continue;
        [orderedDic setObject:paramDic[key] forKey:key];
    }
    NSString *paramMD5 = [MD5 encryptionStr:AFQueryStringFromParameters(orderedDic)];
    NSString *sginCode = [MD5 encryptionStr:[NSString stringWithFormat:@"%@%@%@",
                                             paramMD5, NMAppSecret,
                                             paramDic[@"time"]]];

    return sginCode;
    
}
@end
