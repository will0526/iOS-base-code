//
//  UserDefaultUtil.h
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 缓存本地存储工具类
 */
@interface UserDefaultUtil : NSObject

/**
 通过键值对存储数据
 @param value 存储值 Value
 @param key 存储键 Key
 @return 是否保存成功
 */
+(BOOL) saveValue:(id)value forKey:(NSString *)key;

/**
 通过Key获取存储Value
 @param key 存储键 Key
 @returns 存储值 Value
 */
+(id) getValueByKey:(NSString *)key;

/**
 通过Key删除存储的Value
 @param key 存储键 Key
 */
+(BOOL) removeValueByKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
