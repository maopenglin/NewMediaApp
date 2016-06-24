//
//  HttpRequstTool.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HttpRequstTool : NSObject
+ (void)cancelAllRequest;
+ (AFHTTPSessionManager *)getHttpRequestManager;
+ (NSMutableDictionary *)createGeneralParamDic;


+ (void)httpRequestForPost:(NSString *)requestUrl
                parameters:(NSMutableDictionary *)parameters
                   modules:(NSString *)modules
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;


+ (void)httpRequestForGet:(NSString *)requestUrl
               parameters:(NSMutableDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
@end
