//
//  PIButton.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/6/3.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "PIButton.h"
@interface PIButton()

@property(nonatomic,copy)btnClickActionBlock clickBlock;
@end
@implementation PIButton

-(void)addTarGetForControlEvents:(UIControlEvents)controlEvents action:(btnClickActionBlock)block{
    [self addTarget:self action:@selector(actionClick) forControlEvents:controlEvents];
    self.clickBlock=block;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}
-(void)actionClick{
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}
@end
