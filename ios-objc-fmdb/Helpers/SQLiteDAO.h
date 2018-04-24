//
//  SQLiteDAO.h
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import FMDB;
@import Foundation;

@interface SQLiteDAO : NSObject

+ (SQLiteDAO *)sharedManager;

/**
 UPDATE、INSERT、またはDELETEを実行するトランザクション処理
 
 @param sql (NSString *) SQL文
 @param dataArray (NSArray <NSArray *> *) パラメータの配列をデータ件数分持つ配列
 @return 実行結果 YES: 成功, NO: 失敗
 */
- (BOOL)executeUpdateWithSQL:(NSString *)sql
               withDataArray:(NSArray <NSArray*> *)dataArray;

/**
 SELECTを実行する

 @param sql SQL文
 @param data パラメータの配列
 @return 取得結果の配列
 */
- (NSArray <NSDictionary *> *)executeQueryWithSQL:(NSString *)sql
                                    withArguments:(NSArray *)data;
@end

