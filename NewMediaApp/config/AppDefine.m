//
//  AppDefine.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/6/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "AppDefine.h"

@implementation AppDefine
NSString *const AppUUIDKey = @"AppUUIDKey";


float NMFontScale(float num){
    return ([[UIScreen mainScreen] bounds].size.width/320)*num;
}

UIFont * UIFontScale(float num){
    return [UIFont systemFontOfSize:NMFontScale(num)];
}

UIColor * UIColorHEX(NSString *color){
    if (!color) { return  [UIColor whiteColor];}
    return [CommUtils colorWithHexString:color];
}

UIColor * UIColorRGB(CGFloat r,CGFloat g,CGFloat b ,CGFloat alpha){
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}
@end
