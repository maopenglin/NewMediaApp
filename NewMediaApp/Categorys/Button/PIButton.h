//
//  PIButton.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/6/3.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 如果按钮的点击区域小于44*44 则放大点击区域到44*44
 **/

typedef void(^btnClickActionBlock)(id clickBtn);

@interface PIButton : UIButton
-(void)addTarGetForControlEvents:(UIControlEvents)controlEvents action:(btnClickActionBlock)block;
@end
