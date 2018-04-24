//
//  Paths.h
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;
@import UIKit;

extern const

@interface Paths : NSObject

UIKIT_EXTERN NSString *const STV_SQLITE_NAME;

/**
 DocumentsディレクトリのPATHを取得する

 @return DocumentsディレクトリのPATH
 */
+ (NSString *)documentsDirectory;


/**
 アプリ内SQLiteDBのPATHを取得する

 @return アプリ内SQLiteDBのPATH
 */
+ (NSString *)sqliteDB;
@end
