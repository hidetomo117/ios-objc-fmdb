//
//  Paths.m
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "Paths.h"

@implementation Paths

NSString *const STV_SQLITE_NAME = @"stv.db";

+ (NSString *)documentsDirectory {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)sqliteDB {
    return [[self documentsDirectory] stringByAppendingPathComponent:STV_SQLITE_NAME];
}
@end
