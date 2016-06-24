//
//  NMBaseViewController.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/18.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "NMBaseViewController.h"
static NMBaseViewController *instance;
@implementation NMBaseViewController
+(NMBaseViewController *)sharedInstance{
    return instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    instance=self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    instance=self;
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
@end
