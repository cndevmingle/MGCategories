//
//  NSDate+MGDate.h
//  MGCategories
//
//  Created by Mingle on 2018/1/31.
//

#import <Foundation/Foundation.h>


#define kMGDAYTIMEINTERVAL              (24*60*60)
#define kMGHOURTIMEINTERVAL             (60*60)
#define kMGMINUTETIMEINTERVAL           (60)

NS_ASSUME_NONNULL_BEGIN
@interface NSDate (MGDate)

/**
 创建一个日期对象

 @param dateString 日期字符串
 @param format 日期格式字符串
 @return 日期实例
 */
+ (nullable NSDate *)mg_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 获取日期的字符串

 @param format 日期格式字符串
 @return 日期字符串
 */
- (nullable NSString *)mg_stringWithFormat:(NSString *)format;

/**
 获取偏移的日期

 @param offset 偏移时间（s）
 @return 偏移的日期
 */
- (NSDate *)mg_dateWithOffset:(NSTimeInterval)offset;

/**
 获取昨天

 @return 昨天
 */
- (NSDate *)mg_yesterday;

/**
 获取明天日期

 @return 明天
 */
- (NSDate *)mg_tomorrow;

/**
 单独获取年月日时分秒
 */
- (NSUInteger)mg_year;
- (NSUInteger)mg_month;
- (NSUInteger)mg_day;
- (NSUInteger)mg_hour;
- (NSUInteger)mg_minute;
- (NSUInteger)mg_second;
- (NSUInteger)mg_weekday;

@end
NS_ASSUME_NONNULL_END
