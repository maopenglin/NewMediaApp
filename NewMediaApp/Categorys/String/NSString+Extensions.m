//
//  NSString+Extensions.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/6/2.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>
#import "RequestKeyTool.h"

@implementation NSString(Extensions)
-(NSString *)md5{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (int) data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (BOOL)isEmpty {
    if ([self length] <= 0 || self == (id)[NSNull null] || self == nil) {
        return YES;
    }
    return NO;
}
-(NSURL *)toURL{
    return [NSURL URLWithString:self];
}
- (BOOL (^)(NSString *))isMatch {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^(NSString *regexString) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
        return [predicate evaluateWithObject:originString];
    };
    return result;
}
- (BOOL (^)())isEmail {

    BOOL (^ result)() = ^() {
        return self.isMatch(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}");
    };
    return result;
}
-(NSString *)decodeBase64{
    return  [[RequestKeyTool sharedRequestKeyTool] decryptBase64Data:self];
}
@end
