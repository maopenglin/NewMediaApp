
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5

+ (NSString *)encryptionStr:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(data.bytes, (int) data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}
@end
