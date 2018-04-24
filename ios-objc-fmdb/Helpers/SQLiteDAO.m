//
//  SQLiteDAO.m
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "Paths.h"
#import "SQLiteDAO.h"

@interface SQLiteDAO ()
@property (nonatomic) FMDatabase *fmdb;
@property (nonatomic) dispatch_semaphore_t semaphore;
@end

@implementation SQLiteDAO

# pragma mark - Singleton

static SQLiteDAO *sharedInstance = nil;

+ (SQLiteDAO *)sharedManager {

    // dispatch_once_t を利用することでインスタンス生成を1度に制限する
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SQLiteDAO alloc] init];
    });
    return sharedInstance;
}

/**
 外部からallocされた時のためにallocWithZoneをオーバーライドして、
 一度しかインスタンスを返さないようにする
 */
+ (id)allocWithZone:(NSZone *)zone {

    __block id ret = nil;

    static dispatch_once_t oncePredicate;
    dispatch_once( &oncePredicate, ^{
        sharedInstance = [super allocWithZone:zone];
        ret = sharedInstance;
    });

    return  ret;
}

/**
 copyで別インスタンスが返されないようにするため
 copyWithZoneをオーバーライドして、自身のインスタンスを返すようにする。
 */
- (id)copyWithZone:(NSZone *)zone{

    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fmdb = [FMDatabase databaseWithPath:[Paths sqliteDB]];

        // 同時アクセス許可数に1を指定する(同時に2箇所で使用されない)
        self.semaphore = dispatch_semaphore_create(1);

        NSLog(@"SQLiteDB: %@", [Paths sqliteDB]);
    }
    return self;
}

# pragma mark - Data Access

- (BOOL)executeUpdateWithSQL:(NSString *)sql
               withDataArray:(NSArray <NSArray*> *)dataArray {

    // セマフォを使用することを宣言(どこかでセマフォが使われている間はここで待つ)
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);

    [self.fmdb open];
    [self.fmdb beginTransaction];

    BOOL result = YES;

    if (dataArray && dataArray.count != 0) {
        for (NSArray *data in dataArray) {

            // SQL実行結果が失敗の場合、ループを抜ける
            if (![self.fmdb executeUpdate:sql withArgumentsInArray:data]) {
                result = NO;
                break;
            }
        }
    } else {
        // SQLを1件実行
        result = [self.fmdb executeUpdate:sql];
    }

    // SQLエラーチェック
    BOOL hadError = [self.fmdb hadError];
    if (hadError) {

        NSLog(@"lastErrorCode: %d", [self.fmdb lastErrorCode]);
        NSLog(@"lastErrorMessage: %@", [self.fmdb lastErrorMessage]);
    }

    if (!result || hadError) {
        [self.fmdb rollback];
    } else {
        [self.fmdb commit];
    }

    [self.fmdb close];

    // セマフォを使い終わったことを宣言
    dispatch_semaphore_signal(self.semaphore);

    return result;
}

- (NSArray <NSDictionary *> *)executeQueryWithSQL:(NSString *)sql
                                    withArguments:(NSArray *)data {

    // セマフォを使用することを宣言(どこかでセマフォが使われている間はここで待つ)
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);

    [self.fmdb open];

    FMResultSet *results = [self.fmdb executeQuery:sql withArgumentsInArray:data];

    // SQLエラーチェック
    BOOL hadError = [self.fmdb hadError];
    if (hadError) {

        NSLog(@"lastErrorCode: %d", [self.fmdb lastErrorCode]);
        NSLog(@"lastErrorMessage: %@", [self.fmdb lastErrorMessage]);

        [results close];
        [self.fmdb close];

        // セマフォを使い終わったことを宣言
        dispatch_semaphore_signal(self.semaphore);
        return nil;
    }

    NSMutableArray <NSDictionary *> *mutableResultDics = [@[] mutableCopy];
    while ([results next]) {
        [mutableResultDics addObject:results.resultDictionary];
    }

    [results close];
    [self.fmdb close];

    // セマフォを使い終わったことを宣言
    dispatch_semaphore_signal(self.semaphore);

    NSArray <NSDictionary *> *resultDics = [mutableResultDics copy];
    return resultDics;
}

@end
