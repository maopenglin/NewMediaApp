
//

#import <Foundation/Foundation.h>

@interface ProgressHDTool : NSObject
/**
 *  展示加载状态
 */
+ (void)showProgressHUD;

/**
 *  隐藏加载状态
 */
+ (void)hideProgressHUD;

/**
 *  展示带文字的加载状态
 */
+ (void)showProgressWithTitle:(NSString *)title;

/**
 *  展示提示信息
 */
+ (void)reminderWithTitle:(NSString *)title;
@end
