//
//  AppDelegate.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+NewMediaApp.h"

#import "NMBaseWebViewController.h"
#import "RequestKeyTool.h"
#import "UIView+Extensions.h"
#import "ViewController.h"

#import "APINetWorkService.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self newMediaAppApplication:application didFinishLaunchingWithOptions:launchOptions];
    [[APINetWorkService sharedAPINetWorkService] testApi];
    

    

    
//    NMBaseWebViewController *base=[[NMBaseWebViewController alloc] init];
//    [base loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.163.com"]]];
//    self.window.rootViewController=base;
   
    ViewController *view=[[ViewController alloc] init];
    self.window.rootViewController=view;
    
    /*
    NSDate* tmpStartData = [NSDate date];
    NSString *content=@"JnGiZXKjZjJ=";
    NSString *result2=[[RequestKeyTool sharedRequestKeyTool ]decryptBase64Data:content];
    
    NSString *nusign=@"U27pDz4zlPOdTI66ur9PQfDXFsKzSY82TtvaGsRyajCm6gn0rJK62H45U1zM2u+VMkH7r8hX6l5PGRPhIm8itwf5XKmbJuFC6nFrOgD8ZPH8AM3Yv0JahDIi6cvVY1kQ1arMdJBLjS+BgYIpPufSVfvt3v7EXrUHYM8XDr92j\/U=";
     // NSLog(@"result:%@",result);
   // NSLog(@"result:%@",sign);
    BOOL result=[[RequestKeyTool sharedRequestKeyTool] rsaValidata:content withSign:nusign];
    NSLog(@"result:%i",result);
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
     */
    [self.window makeKeyAndVisible];
    
    UIView *v1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(80, 0, 10, 20)];
    v1.alignLeft(v2).offsetY(100);
   
    v1.equalToView(v2);
    v1.offsetY(10);
    //v1.alignBottom(v2);
    NSLog(@"v1 x:%f  y:%f",v1.left_ext,v1.top_ext);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
