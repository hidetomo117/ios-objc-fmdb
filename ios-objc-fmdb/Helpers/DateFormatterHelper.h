//
//  DateFormatterHelper.h
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/23.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface DateFormatterHelper : NSObject

UIKIT_EXTERN NSString *const LAST_LOGIN_DATETIME_FORMAT;

/**
 UTC日付の文字列に変換する

 @param date SQLiteに書き込む日付
 @param dateFormat フォーマット
 @return UTC日付の文字列
 */
+ (NSString *)dateStringForSQLite:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 UTC日付文字列をNSDate(GMT)に変換する

 @param dateString SQLiteでSELECTした日付文字列
 @param dateFormat フォーマット
 @return NSDate
 */
+ (NSDate *)dateFromSQLite:(NSString *)dateString dateFormat:(NSString *)dateFormat;
@end
