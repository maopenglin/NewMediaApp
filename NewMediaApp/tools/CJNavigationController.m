//
//  CJNavigationController.m
//  CJNavigationController
//
//  Created by Jay_pc on 15/10/27.
//  Copyright © 2015年 CrazyCJay. All rights reserved.
//

#import "CJNavigationController.h"


#define CJScreenHeight [UIScreen mainScreen].bounds.size.height
#define CJScreenWidth [UIScreen mainScreen].bounds.size.width

#define CJOffsetFloat  0.65// 拉伸参数
#define CJOffetDistance 100// 最小回弹距离

@interface CJNavigationController ()

@property(nonatomic,assign) CGPoint mStartPoint;

@property(nonatomic,strong) UIView *mLastScreenShotView;

@property (nonatomic, strong) UIView *mBgView;

@property (nonatomic, strong) NSMutableArray *mScreenShots;

@property (nonatomic, assign) BOOL mIsMoving;


@end

@implementation CJNavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cj_canDragBack = YES;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shadowOffset = CGSizeMake(0, 10);
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 10;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.masksToBounds=NO;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didHandlePanGesture:)];
    recognizer.delegate=self;
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    NSString *class=[NSString stringWithFormat:@"%@",[[self.viewControllers lastObject] class]];
//   
//    if ([class compare:@"IndexViewController"]==NSOrderedSame) {
//        return  NO;
//    }
//    if ([class compare:@"MyDocumentViewController"]==NSOrderedSame) {
//        MyDocumentViewController *obj=(MyDocumentViewController*)[self.viewControllers lastObject];
//        return [obj canDragBack];
//        
//    }
   // if (self.viewControllers.count>1) {
        return YES;
   // }
    return NO;
}
-(NSMutableArray *)mScreenShots{
    if (!_mScreenShots) {
        _mScreenShots = [NSMutableArray new];
    }
    return _mScreenShots;
}
//初始化截屏的view
-(void)initViews{

    self.view.backgroundColor = CTColorString(@"f4f4f4");
    if (!self.mBgView) {
        self.mBgView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.mBgView.backgroundColor =CTColorString(@"f4f4f4");
        [self.view.superview insertSubview:self.mBgView belowSubview:self.view];
    }
    self.mBgView.hidden = NO;
    if (self.mLastScreenShotView) [self.mLastScreenShotView removeFromSuperview];
    self.mLastScreenShotView =[self.mScreenShots lastObject ];
    self.mLastScreenShotView.frame = (CGRect){-(CJScreenWidth*CJOffsetFloat),0,CJScreenWidth,CJScreenHeight};
    [self.mBgView addSubview:self.mLastScreenShotView];
}
//改变状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        [self.mScreenShots addObject:[self capture]];
    }
    [super pushViewController:viewController animated:animated];
    
}
-(void)pushAnimation:(UIViewController *)viewController{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.1];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [super pushViewController:viewController animated:NO];
    [self.view.layer addAnimation:animation forKey:nil];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (animated) {
        [self popAnimation];
        return nil;
    } else {
        return [super popViewControllerAnimated:animated];
    }
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
     NSArray *arr= self.viewControllers;
    NSString *class=[NSString stringWithFormat:@"%@",[viewController class]];
    for(int i=(int)arr.count-1;i>=0;i--){
        UIViewController *con=arr[i];
        NSString *controllerClass=[NSString stringWithFormat:@"%@",[con class]];
        if ([controllerClass compare:class]==NSOrderedSame) {
             break;
        }else{
           [self.mScreenShots removeLastObject];
        }
    }
    
    return [super popToViewController:viewController animated:animated];
}
- (void) popAnimation {
    if (self.viewControllers.count == 1) {
        return;
    }
    [self initViews];
    [UIView animateWithDuration:0.3 animations:^{
        [self doMoveViewWithX:CJScreenWidth];
    } completion:^(BOOL finished) {
        [self completionPanBackAnimation];
    }];
}


- (UIView *)capture
{
  return  [self.view snapshotViewAfterScreenUpdates:NO];
}
#pragma mark ------------  UIPanGestureRecognizer -------

-(void)didHandlePanGesture:(UIPanGestureRecognizer *)recoginzer{
    if (self.viewControllers.count <= 1 && !self.cj_canDragBack) return;
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication]keyWindow]];
    
    CGFloat offsetX = touchPoint.x - self.mStartPoint.x;
    if(recoginzer.state == UIGestureRecognizerStateBegan)
    {
       
        [self initViews];
        _mIsMoving = YES;
        _mStartPoint = touchPoint;
        offsetX = 0;
        
        UIViewController *conn= [self.viewControllers lastObject];
        [conn.view endEditing:YES];
        
    }
    
    if(recoginzer.state == UIGestureRecognizerStateEnded)
    {
        if (offsetX > CJOffetDistance)
        {
            [UIView animateWithDuration:0.2 animations:^{
                [self doMoveViewWithX:CJScreenWidth];
            } completion:^(BOOL finished) {
                [self completionPanBackAnimation];
                
                self.mIsMoving = NO;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                [self doMoveViewWithX:0];
            } completion:^(BOOL finished) {
                self.mIsMoving = NO;
                self.mBgView.hidden = YES;
            }];
        }
        self.mIsMoving = NO;
    }
    if(recoginzer.state == UIGestureRecognizerStateCancelled)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self doMoveViewWithX:0];
        } completion:^(BOOL finished) {
            self.mIsMoving = NO;
            self.mBgView.hidden = YES;
        }];
        self.mIsMoving = NO;
    }
    if (self.mIsMoving) {
        [self doMoveViewWithX:offsetX];
    }
}
-(void)doMoveViewWithX:(CGFloat)x{
  
    
    x = x>CJScreenWidth?CJScreenWidth:x;
    x = x<0?0:x;
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    self.mLastScreenShotView.frame = (CGRect){-(CJScreenWidth*CJOffsetFloat)+x*CJOffsetFloat,0,CJScreenWidth,CJScreenHeight};
}
-(void)completionPanBackAnimation{
    [self.mScreenShots removeLastObject];
    [super popViewControllerAnimated:NO];
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    self.view.frame = frame;
    self.mBgView.hidden = YES;
}


@end