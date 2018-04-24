//
//  User.m
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "User.h"
#import "DateFormatterHelper.h"

// Categories
#import "NSObject+NullToNil.h"

@implementation User

- (instancetype)initWithUserID:(NSString *)userID
                      userName:(NSString *)userName
             lastLoginDateTime:(NSDate *)lastLoginDateTime {

    self = [super init];
    if (self) {
        self.userID = userID;
        self.userName = userName;
        self.lastLoginDateTime = lastLoginDateTime;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)selectResult {

    NSString *userID = [selectResult[@"user_id"] nullToNil];
    NSString *userName = [selectResult[@"user_name"] nullToNil];

    NSString *dateString = [selectResult[@"last_login_datetime"] nullToNil];
    NSDate *lastLoginDateTime = [DateFormatterHelper dateFromSQLite:dateString dateFormat:LAST_LOGIN_DATETIME_FORMAT];
    
    return [[User alloc] initWithUserID:userID userName:userName lastLoginDateTime:lastLoginDateTime];
}
@end
