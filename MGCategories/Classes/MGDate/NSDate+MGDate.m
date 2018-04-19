//
//  NSDate+MGDate.m
//  MGCategories
//
//  Created by Mingle on 2018/1/31.
//

#import "NSDate+MGDate.h"

@implementation NSDate (MGDate)

#pragma mark - 创建一个日期对象
+ (NSDate *)mg_dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    return [fmt dateFromString:dateString];
}

#pragma mark - 获取日期字符串
- (NSString *)mg_stringWithFormat:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    return [fmt stringFromDate:self];
}

#pragma mark - 获取偏移后的日期
- (NSDate *)mg_dateWithOffset:(NSTimeInterval)offset {
    NSDate *date = [self dateByAddingTimeInterval:offset];
    return date;
}

#pragma mark - 昨天
- (NSDate *)mg_yesterday {
    return [self mg_dateWithOffset:-kMGDAYTIMEINTERVAL];
}

#pragma mark - 明天
- (NSDate *)mg_tomorrow {
    return [self mg_dateWithOffset:kMGDAYTIMEINTERVAL];
}

#pragma mark - 单独获取年月日时分秒
- (NSUInteger)mg_year {
    return [self mg_stringWithFormat:@"yyyy"].integerValue;
}

- (NSUInteger)mg_month {
    return [self mg_stringWithFormat:@"MM"].integerValue;
}

- (NSUInteger)mg_day {
    return [self mg_stringWithFormat:@"dd"].integerValue;
}

- (NSUInteger)mg_hour {
    return [self mg_stringWithFormat:@"HH"].integerValue;
}

- (NSUInteger)mg_minute {
    return [self mg_stringWithFormat:@"mm"].integerValue;
}

- (NSUInteger)mg_second {
    return [self mg_stringWithFormat:@"ss"].integerValue;
}

- (NSUInteger)mg_weekday {
    return [self mg_stringWithFormat:@"w"].integerValue;
}

@end
