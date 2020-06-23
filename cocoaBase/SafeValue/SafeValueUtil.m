//
//  NSDictionary+Extension.m
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "SafeValueUtil.h"


CP_EXTERN id EncodeObjectFromDic(NSDictionary *dic, NSString *key)
{
    
    if (IsNilOrNull(dic)) {
        return nil;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    NSString *value = @"";
    if (NotNilAndNull(temp))   {
        if ([temp isKindOfClass:[NSString class]]) {
            value = temp;
        }else if([temp isKindOfClass:[NSNumber class]]){
            value = [temp stringValue];
        }
        return value;
    }
    return nil;
}

CP_EXTERN NSString* EncodeDefaultStrFromDic(NSDictionary *dic, NSString *key,NSString * defaultStr)
{
    if (IsNilOrNull(dic)) {
        return nil;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    NSString *value = defaultStr;
    if (NotNilAndNull(temp))   {
        if ([temp isKindOfClass:[NSString class]]) {
            value = temp;
        }else if([temp isKindOfClass:[NSNumber class]]){
            value = [temp stringValue];
        }
        
        return value;
    }
    return value;
}

CP_EXTERN id SafeObjectAtIndex(NSArray *arr, NSInteger index)
{
    if (IsArrEmpty(arr)) {
        
        return nil;
    }
    
    if ([arr count]-1<index) {
        
        return nil;
    }
    
    return [arr objectAtIndex:index];
}



CP_EXTERN NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic)) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

CP_EXTERN NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic)) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

CP_EXTERN NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic)) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

CP_EXTERN NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic)) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

CP_EXTERN NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic))
{
    if (IsNilOrNull(dic)) {
        return nil;
    }
    NSArray *tempList = EncodeArrayFromDic(dic, key);
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto) {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}

CP_EXTERN void EncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return;
    }
    
    if (IsStrEmpty(object))
    {
        return;
    }
    
    if (IsStrEmpty(key))
    {
        return;
    }
    @try {
        [dic setObject:object forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"dic setObject exception%@",exception);
    } @finally {
        
    }
    
}

CP_EXTERN void EncodeUnEmptyObjctToArray(NSMutableArray *arr,id object)
{
    if (IsNilOrNull(arr))
    {
        return;
    }
    
    if (IsNilOrNull(object))
    {
        return;
    }
    
    [arr addObject:object];
}

CP_EXTERN void EncodeDefaultStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key,NSString * defaultStr)
{
    if (IsNilOrNull(dic))
    {
        return;
    }
    
    if (IsStrEmpty(object))
    {
        object = defaultStr;
    }
    
    if (IsStrEmpty(key))
    {
        return;
    }
    
    @try {
        [dic setObject:object forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"dic setObject exception%@",exception);
    } @finally {
        
    }
}
