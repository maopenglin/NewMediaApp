//
//  AppDefine.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/6/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDefine : NSObject
UIKIT_EXTERN NSString *const AppUUIDKey;


/**
    #NMFontScal 字体大小适配
 **/

FOUNDATION_EXPORT float NMFontScale(float num);
/**
   #UIFontScale 默认字体简写
 **/
FOUNDATION_EXPORT UIFont * UIFontScale(float num);

/**
    #hex颜色
 **/
FOUNDATION_EXPORT UIColor * UIColorHEX(NSString *color);

/**
 #RGB颜色
 **/
FOUNDATION_EXPORT UIColor * UIColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat alpha);

/**
   #获取UUID
 **/
FOUNDATION_EXPORT NSString * UUID_APP();
@end
