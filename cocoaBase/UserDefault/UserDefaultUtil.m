//
//  UserDefaultUtil.m
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "UserDefaultUtil.h"
#import "GlobalDefine.h"
@implementation UserDefaultUtil


#pragma mark - UD存储
/**
 通过键值对存储数据
 @param value 存储值 Value
 @param key 存储键 Key
 @return 是否保存成功
 */
+(BOOL) saveValue:(id)value forKey:(NSString *)key;
{
    if (IsNilOrNull(value)) {
        return NO;
    }
    if (IsStrEmpty(key)) {
        return NO;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    @try {
        [defaults setObject:value forKey:key];
        [defaults synchronize];
        return YES;
    } @catch (NSException *exception) {
        return NO;
    } @finally {
        
    }
}

/**
 通过Key获取存储Value
 @param key 存储键 Key
 @returns 存储值 Value
 */
+(id) getValueByKey:(NSString *)key
{
    if (IsStrEmpty(key)) {
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

/**
 通过Key删除存储的Value
 @param key 存储键 Key
 */
+(BOOL) removeValueByKey:(NSString *)key
{
    if (IsStrEmpty(key)) {
        return NO;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
    return YES;
}


@end
