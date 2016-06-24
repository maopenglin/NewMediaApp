//
//  AppDelegate+NewMediaApp.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/18.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface AppDelegate (NewMediaApp)
-(void)newMediaAppApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)showShareSDKInViewController:(UIViewController *)controller
                         andPopView:(UIView *)view
                      andShareTitle:(NSString *)title
                       andShareDesc:(NSString *)desc
                 andShareThumbImage:(NSString *)httpThumbUrl
                        andShareUrl:(NSString *)shareUrl;
@end
