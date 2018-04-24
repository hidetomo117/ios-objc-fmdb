//
//  ViewController.m
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "ViewController.h"
#import "UserDAO.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([UserDAO createUserTable]) {
        NSLog(@"CREATE TABLE成功");
        [self usageOfUserDAO];
    } else {
        NSLog(@"CREATE TABLE失敗");
    }
}

# pragma mark - Usage

- (void)usageOfUserDAO {

    NSString *uniqueUserID = @"1qazxsw23edc";
    NSString *userName = @"K.S";
    User *theUser = [[User alloc] initWithUserID:uniqueUserID userName:userName lastLoginDateTime:[NSDate date]];
    BOOL result = [UserDAO insertWithUserID:theUser.userID userName:theUser.userName];
    if (result) {
        NSLog(@"INSERT成功");
    } else {
        NSLog(@"INSERT失敗");
    }

    User *insertedUser = [UserDAO selectByUserID:uniqueUserID];
    NSLog(@"userID: %@", insertedUser.userID);
    NSLog(@"userName: %@", insertedUser.userName);
    NSLog(@"lastLoginDateTime: %@", insertedUser.lastLoginDateTime);

    User *renamedUser = [[User alloc] initWithUserID:uniqueUserID userName:@"K.O" lastLoginDateTime:[NSDate date]];
    BOOL updateResult = [UserDAO updateUser:renamedUser];
    if (updateResult) {
        NSLog(@"UPDATE成功");
    } else {
        NSLog(@"UPDATE失敗");
    }

    User *updatedUser = [UserDAO selectByUserID:@"1qazxsw23edc"];
    NSLog(@"userID: %@", updatedUser.userID);
    NSLog(@"userName: %@", updatedUser.userName);
    NSLog(@"lastLoginDateTime: %@", updatedUser.lastLoginDateTime);

    BOOL deleteResult = [UserDAO deleteWithUserID:updatedUser.userID];
    if (deleteResult) {
        NSLog(@"DELETE成功");
    } else {
        NSLog(@"DELETE失敗");
    }
}

@end
