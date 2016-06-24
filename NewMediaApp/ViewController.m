//
//  ViewController.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PIButton.h"
#import <YYKit/YYKit.h>
@interface ViewController ()

@end

@implementation ViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    PIButton *pibtn=[[PIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 40)];
    pibtn.backgroundColor=[UIColor redColor];
   
    YYAnimatedImageView *icon=[[YYAnimatedImageView  alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [icon setImageWithURL:[NSURL URLWithString:@"http://img.ui.cn/data/file/4/6/8/44864.gif"] options:YYWebImageOptionAllowBackgroundTask];
    [self.view addSubview:icon];
    
    [pibtn  addTarGetForControlEvents:UIControlEventTouchUpInside action:^(PIButton *btn)  {
        NSLog(@"btn click");
    }];
    
    
    YYLabel *yylab=[[YYLabel alloc] initWithFrame:CGRectMake(10, 300, 100, 25)];
    yylab.text=@"测试汉字";
    yylab.backgroundColor=[UIColor clearColor];
    yylab.font=UIFontScale(15);
    [self.view addSubview:yylab];
    
    [self.view addSubview:pibtn];
    
    /*
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, -50,600, 80)];
    v.backgroundColor=[UIColor redColor];
    [self.view addSubview:v];
    
    
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height,600, 280)];
    v2.backgroundColor=[UIColor blueColor];
    [self.view addSubview:v2];
    
   
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.4
                        options:0
                     animations:^{
                         v.frame=CGRectMake(0, 64,600, 80);
                         [v layoutIfNeeded];
                     } completion:NULL];
    
    [UIView animateWithDuration:0.6
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.7
                        options:0
                     animations:^{
                         v2.frame=CGRectMake(0, 144,600, 280);
                         [v layoutIfNeeded];
                     } completion:NULL];

    
//    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    frameAnimation.duration = .5;
//    frameAnimation.autoreverses=YES;
//   // frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    frameAnimation.fromValue = [NSValue valueWithCGRect:v.frame];
//    frameAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 80, 1000, 1500)];
//    [v.layer addAnimation:frameAnimation forKey:nil];
    
    
  */
    
    UIView *frontView = [[UIView alloc] initWithFrame:self.view.bounds];
    frontView.backgroundColor =UIColorHex(f3ff33);
   
         // 后台页面
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    backView.backgroundColor = [UIColor redColor];
         [self.view addSubview:backView];
         [self.view addSubview:frontView];
    
    [UIView transitionFromView:frontView toView:backView duration:0.5 options:UIViewAnimationOptionCurveEaseIn completion:^(BOOL finished) {
        
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
