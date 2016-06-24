//
//  APINetWorkService.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "APINetWorkService.h"
#import "HttpRequstTool.h"
#import "AFNetworking.h"
@implementation APINetWorkService
SYNTHESIZE_SINGLETON_FOR_CLASS(APINetWorkService)

-(void)testApi{
   [HttpRequstTool httpRequestForGet:@"http_url" parameters:nil success:^(id responseObject) {
       NSLog(@"response:%@",responseObject);
   } failure:^(NSError *error) {
       
   }];


   
}

@end
