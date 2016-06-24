
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

/**
*  字符串MD5加密
*
*  @param str 需要加密字符串
*
*/
+ (NSString *)encryptionStr:(NSString *)str;

@end
