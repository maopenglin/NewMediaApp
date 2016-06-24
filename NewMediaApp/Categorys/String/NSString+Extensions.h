//
//  NSString+Extensions.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/6/2.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extensions)
-(NSString *)md5;
- (BOOL)isEmpty;
- (BOOL (^)())isEmail;
-(NSString *)decodeBase64;
-(NSURL *)toURL;
@end
