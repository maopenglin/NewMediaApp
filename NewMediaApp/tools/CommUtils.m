
//

#define refresViewMaxTime 5
#import <MediaPlayer/MediaPlayer.h>
#import  <AVFoundation/AVFoundation.h>

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation CommUtils

+ (BOOL)isNull:(NSString *)str {
    if (str == nil) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }

    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    if (str.length == 0) {
        return YES;
    }
    return NO;
}

+(BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€  "]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}


+ (BOOL)checkEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if ([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        NSInteger indexOfDot = aRange.location;
        if (aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if (topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor

+ (UIColor *)colorWithHexString:(NSString *)color {
    if (!color){
        return [UIColor clearColor];
    }
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    //r
    NSString *rString = [cString substringWithRange:range];

    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (NSString *)intervalSinceNow:(NSDate *)d {

    //    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    //    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *d=[date dateFromString:theDate];

    NSTimeInterval late = [d timeIntervalSince1970] * 1;


    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSString *timeString = @"";

    NSTimeInterval cha = now - late;

    if (cha / 3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 60];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];

    }
    if (cha / 3600 > 1 && cha / 86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 3600];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha / 86400 > 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 86400];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];

    }
    return timeString;
}

+ (NSString *)getWeather:(int)wid {

    switch (wid) {
        case 0:
        case 1:
        case 2:
        case 3:
            return @"\U0000E615";
            break;

        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
            return @"\U0000E61B";
            break;
        case 9:
            return @"\U0000E60B";
            break;
        case 10:
            return @"\U0000E617";
            break;
        case 11:
            return @"\U0000E618";
            break;
        case 12:
            return @"\U0000E620";
            break;
        case 13:
            return @"\U0000E60D";
            break;
        case 14:
            return @"\U0000E608";
            break;
        case 15:
            return @"\U0000E606";
            break;
        case 16:
            return @"\U0000E605";
            break;
        case 17:
            return @"\U0000E604";
            break;
        case 18:
            return @"\U0000E603";
            break;
        case 19:
        case 20:
        case 21:
            return @"\U0000E60C";//19冻雨 没有图标用的雨夹雪
            break;


        case 22:
            return @"\U0000E611";
            break;
        case 23:
            return @"\U0000E602";
            break;
        case 24:
            return @"\U0000E600";
            break;
        case 25:
            return @"\U0000E601";
            break;
        case 26:
            return @"\U0000E619";
            break;
        case 27:
        case 28:
        case 29:
            return @"\U0000E616";
            break;
        case 30:
            return @"\U0000E612";
            break;
        case 31:
            return @"\U0000E612";//这个霾 图标没有
            break;
        case 32:
        case 33:
            return @"\U0000E61A";
            break;
        case 34://飓风 图标没有
        case 35://热带风暴
        case 36://龙卷风
            return @"\U0000E614";
            break;
        case 37://冷 图标没有
            return @"\U0000E614";
            break;
        case 38:
            return @"\U0000E615";
            break;
        default:
            return @"\U0000E615";
            break;
    }
    return @"\U0000E615";
}

+ (BOOL)needRefreshByViewId:(NSString *)viewId {
    if (!viewId) {
        return NO;
    }
    NSDate *lastDate = [self getNowDateFromatAnDate:[[NSUserDefaults standardUserDefaults] objectForKey:viewId]];
    if (lastDate == nil) {
        return NO;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *senddate = [self getNowDateFromatAnDate:[NSDate date]];
    //    结束时间
    //    NSDate *endDate = [dateFormatter dateFromString:@"2014-11-12 15:48:00"];
    //当前时间
    NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:senddate]];
    //得到相差秒数
    NSTimeInterval time = [senderDate timeIntervalSinceDate:lastDate];
    //    NSLog(@"相差：%@  秒",[[NSString alloc] initWithFormat:@"%i",(int)time]);
    if ((int) time >= 60 * refresViewMaxTime) {
        return YES;
    }
    return NO;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone *destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
/**
 获取视频的第一帧图片
 */
+ (UIImage *)generateVideoThumb:(NSString *)videoPath
{
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoURL options:opts];
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(800, 600);//视频大小
    NSError *error = nil;
    CGImageRef cgImg = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
    if (error == nil) {
        UIImage *image =  [UIImage imageWithCGImage:cgImg];
        CGImageRelease(cgImg);
        return image;
    } else {
        //NSLog(@"Can not generate thumb from video, %@", error);
        return nil;
    }
}

+ (NSString *)compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+ (NSString *)getAppName {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDict objectForKey:@"CFBundleDisplayName"];
    return appName;
}



+ (NSString *)timeToHumanString:(unsigned long)ms {
    unsigned long seconds, h, m, s;
    char buff[128] = { 0 };
    NSString *nsRet = nil;
    
    seconds = ms / 1000;
    h = seconds / 3600;
    m = (seconds - h * 3600) / 60;
    s = seconds - h * 3600 - m * 60;
    if (h >= 1) {
        snprintf(buff, sizeof(buff), "%02ld:%02ld:%02ld", h, m, s);
    }else {
        snprintf(buff, sizeof(buff), "%02ld:%02ld",  m, s);
    }
    nsRet = [[NSString alloc] initWithCString:buff
                                      encoding:NSUTF8StringEncoding];
    
    return nsRet;
}

+ (NSString *)currentPlayTimeWithCurrentTime:(unsigned long)currentTime totalTime:(unsigned long) totalTime {
    unsigned long seconds, h, m, s;
    char buff[128] = { 0 };
    NSString *nsRet = nil;
    seconds = currentTime / 1000;
    h = seconds / 3600;
    m = (seconds - h * 3600) / 60;
    s = seconds - h * 3600 - m * 60;
    if (totalTime / 1000 / 3600 >= 1) {
        snprintf(buff, sizeof(buff), "%02ld:%02ld:%02ld", h, m, s);
    }else {
        snprintf(buff, sizeof(buff), "%02ld:%02ld",  m, s);
    }
    nsRet = [[NSString alloc] initWithCString:buff
                                     encoding:NSUTF8StringEncoding];
    
    return nsRet;
}

+ (BOOL)isLocalMedia:(NSURL*)url {
    static NSString * const local = @"/";
    static NSString * const local2 = @"file://localhost/";
    static NSString * const iPod = @"ipod-library://";
    static NSString * const camera = @"assets-library://";
    
    NSString * urlStr = [url absoluteString];
    if ( [urlStr hasPrefix:local] ) return YES;
    if ( [urlStr hasPrefix:local2] ) return YES;
    if ( [urlStr hasPrefix:iPod] ) return YES;
    if ( [urlStr hasPrefix:camera] ) return YES;
    
    return NO;
}


+  (int)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
    
}







@end
