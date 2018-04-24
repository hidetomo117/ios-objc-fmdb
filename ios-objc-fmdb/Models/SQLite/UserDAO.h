//
//  UserDAO.h
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;
#import "User.h"

@interface UserDAO : NSObject

+ (BOOL)createUserTable;
+ (BOOL)insertWithUserID:(NSString *)userID
                userName:(NSString *)userName;
+ (User *)selectByUserID:(NSString *)userID;
+ (BOOL)updateUser:(User *)user;
+ (BOOL)deleteWithUserID:(NSString *)userID;

@end
