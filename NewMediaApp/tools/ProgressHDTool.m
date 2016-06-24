
//

#import "ProgressHDTool.h"
#import "SVProgressHUD.h"

@implementation ProgressHDTool

#pragma mark 加载状态提示

+ (void)showProgressHUD {
    [SVProgressHUD setRingThickness:2];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
}

+ (void)hideProgressHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismiss];
}

+ (void)showProgressWithTitle:(NSString *)title {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:title];
}

+ (void)reminderWithTitle:(NSString *)title {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showInfoWithStatus:title];
}

@end
