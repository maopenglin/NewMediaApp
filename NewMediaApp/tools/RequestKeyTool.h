//
//  RequestKeyTool.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/30.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestKeyTool : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(RequestKeyTool)
-(NSString *)decryptBase64Data:(NSString *)requestData;

-(BOOL)rsaValidata:(NSString *)input withSign:(NSString *)sign;
@end
