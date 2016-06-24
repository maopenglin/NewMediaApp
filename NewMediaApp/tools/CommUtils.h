
//

#import <Foundation/Foundation.h>

@interface CommUtils : NSObject
/**
*  判断字符串是否为空
*
*  @param str 输入字符串
*
*  @return 返回结果
*/
+ (BOOL)isNull:(NSString *)str;

/**
*  检查邮箱格式
*
*  @param inputText 输入内容
*
*  @return 返回结果
*/
+ (BOOL)checkEmail:(NSString *)inputText;

/**
*  颜色转化
*
*  @param color 颜色 #23232
*
*  @return 返回颜色
*/
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
*  时间转化
*
*  @param d 时间戳
*
*  @return 时间字符串
*/
+ (NSString *)intervalSinceNow:(NSDate *)d;

/**
*  返回天气图标
*
*  @param wid 天气参数
*
*  @return return value description
*/
+ (NSString *)getWeather:(int)wid;

/**
*  判断距离上次刷新是否超过五分钟
*
*  @param viewId 页面id
*
*  @return 返回结果
*/
+ (BOOL)needRefreshByViewId:(NSString *)viewId;

/**
 *  检测是否含有特殊符号
 *
 *  @param str 需要检测的字符串
 *
 *  @return
 */
+(BOOL)isIncludeSpecialCharact: (NSString *)str;


/**
 获取视频的第一帧图片
 */
+(UIImage *)generateVideoThumb:(NSString *)videoPath;


/**
 *  格式化时间
 *
 *  @param compareDate 发布的时间
 *
 *  @return 返回时间差
 */
+ (NSString *)compareCurrentTime:(NSDate*) compareDate;

/**
 *  获取应用名称
 *
 *  @return
 */
+ (NSString *)getAppName;



/**
 *  视频播放时间转化
 *
 *  @param ms 毫秒
 *
 *  @return 时间字符串
 */
+ (NSString *)timeToHumanString:(unsigned long)ms;

/**
 *  视频当前播放时间
 *
 *  @param currentTime 当前时间
 *  @param totalTime   总时间
 *
 *  @return
 */
+ (NSString *)currentPlayTimeWithCurrentTime:(unsigned long)currentTime totalTime:(unsigned long) totalTime;


/**
 *  检测该链接本地缓存
 *
 *  @param url 链接地址
 *
 *  @return
 */
+ (BOOL)isLocalMedia:(NSURL*)url;


+ (int)convertToInt:(NSString*)strtemp;
@end
