//
//  DateUntil.m
//  GeihuiDemo
//
//  Created by peikua on 17/3/23.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

// 根据指定时间字符串返回对应的NSDate。
+ (NSDate *)getDateFromString:(NSString *)aTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:aTimeString];
    return date;
}

// 根据指定时间字符串返回对应的NSDate。
+ (NSDate *)getDateFromString:(NSString *)aTimeString format:(NSString *)format
{
    if(!aTimeString.length || !format.length)return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:aTimeString];
    return date;
}

// 根据指定的NSDate返回对应格式的NSString
+ (NSString *)getTimeStringFromDate:(NSDate *)aDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *setNowDate = [formatter stringFromDate:aDate];
    return setNowDate;
}

//根据指定得时间戳返回对应的时间字符串
+(NSString *)getTimeStringFromDateTimestamp:(NSString *)timestamp
{
    if(timestamp.length == 0 || [timestamp integerValue] == 0){
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

// 获得当前时间。
+ (NSString *)getNowDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *setNowDate = [formatter stringFromDate:now];
    return setNowDate;
}

+ (NSString *)getDayDate{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *setNowDate = [formatter stringFromDate:now];
    return setNowDate;
}

// 获得当前时间戳
+ (NSString *)getNowDateTimestamp
{
    NSDate *date = [DateUtil getDateFromString:[DateUtil getNowDate]];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSNumber *timeIntervalNumber = [NSNumber numberWithDouble:timeInterval];
    return [timeIntervalNumber stringValue];
}


+ (NSTimeInterval)getTimestampFromDate:(NSDate *)date{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}
//根据时间获取时间戳
+ (NSTimeInterval)getTimestampFromDateStr:(NSString *)dateStr format:(NSString *)format{
    NSTimeInterval timeInterval = [[self getDateFromString:dateStr format:format] timeIntervalSince1970];
    return timeInterval;
}

//获取当前星期几
+ (NSString *)getWeekdayForDate:(NSDate *)date{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    [componets setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    NSArray *weeks = @[@"",@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    return [weeks objectAtIndex:[componets weekday]];
}

@end
