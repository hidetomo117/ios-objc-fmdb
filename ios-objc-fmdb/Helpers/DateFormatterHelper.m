//
//  DateFormatterHelper.m
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/23.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "DateFormatterHelper.h"

@implementation DateFormatterHelper

NSString *const LAST_LOGIN_DATETIME_FORMAT = @"yyyy-MM-dd HH:mm:ss";

+ (NSString *)dateStringForSQLite:(NSDate *)date dateFormat:(NSString *)dateFormat {

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromSQLite:(NSString *)dateString dateFormat:(NSString *)dateFormat {

    if (!dateString) {
        return nil;
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:dateString];
}
@end
