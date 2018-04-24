//
//  UserDAO.m
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "DateFormatterHelper.h"
#import "SQLiteDAO.h"
#import "UserDAO.h"

// Categories
#import "NSObject+NullToNil.h"

@implementation UserDAO

# pragma mark - CREATE TABLE

+ (BOOL)createUserTable {

    NSString *sql = @"CREATE TABLE IF NOT EXISTS USER (user_id TEXT NOT NULL PRIMARY KEY, user_name TEXT NOT NULL, last_login_datetime REAL);";
    return [[SQLiteDAO sharedManager] executeUpdateWithSQL:sql withDataArray:nil];
}

# pragma mark - INSERT

+ (BOOL)insertWithUserID:(NSString *)userID
                userName:(NSString *)userName {

    NSString *sql = @"INSERT INTO USER (user_id, user_name, last_login_datetime) VALUES(?, ?, julianday(?));";

    // 現在日時の保存 UTC日付でSQLiteにREAL値でINSERTする
    NSString *dateString = [DateFormatterHelper dateStringForSQLite:[NSDate date] dateFormat:LAST_LOGIN_DATETIME_FORMAT];

    NSArray *data = @[userID, userName, dateString];
    return [[SQLiteDAO sharedManager] executeUpdateWithSQL:sql withDataArray:@[data]];
}

# pragma mark - SELECT

+ (User *)selectByUserID:(NSString *)userID {

    NSString *sql = @"SELECT user_id, user_name, datetime(last_login_datetime, 'localtime') last_login_datetime FROM USER WHERE user_id = ?";

    NSArray <NSDictionary *> *results = [[SQLiteDAO sharedManager] executeQueryWithSQL:sql
                                                                         withArguments:@[userID]];
    if (!results || results.count == 0) {
        return nil;
    }
    User *selectedUser = [[User alloc] initWithDictionary:results.firstObject];
    return selectedUser;
}

# pragma mark - UPDATE

+ (BOOL)updateUser:(User *)user {

    NSString *sql = @"UPDATE USER SET user_name = ?, last_login_datetime = julianday(?) WHERE user_id = ?";

    NSString *dateString = [DateFormatterHelper dateStringForSQLite:user.lastLoginDateTime dateFormat:LAST_LOGIN_DATETIME_FORMAT];
    NSArray *data = @[user.userName, dateString, user.userID];

    return [[SQLiteDAO sharedManager] executeUpdateWithSQL:sql
                                             withDataArray:@[data]];
}

# pragma mark - DELETE

+ (BOOL)deleteWithUserID:(NSString *)userID {

    NSString *sql = @"DELETE FROM USER WHERE user_id = ?";
    NSArray *data = @[userID];

    return [[SQLiteDAO sharedManager] executeUpdateWithSQL:sql withDataArray:@[data]];
}
@end
