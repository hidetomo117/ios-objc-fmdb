//
//  NSObject+NullToNil.h
//  ios-objc-fmdb
//
//  Created by OkuderaYuki on 2018/04/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;

@interface NSObject (NullToNil)

/**
 Nullをnilに変換する

 @return インスタンスがNullの場合: nil, Null出ない場合: 変換元のインスタンス
 */
- (__kindof NSObject *)nullToNil;
@end
