//
//  User.h
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import FMDB;
@import Foundation;

@interface User : NSObject
@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSDate *lastLoginDateTime;

- (instancetype)initWithUserID:(NSString *)userID
                      userName:(NSString *)userName
             lastLoginDateTime:(NSDate *)lastLoginDateTime;

- (instancetype)initWithDictionary:(NSDictionary *)selectResult;
@end
