//
//  NSDictionary+Extension.h
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GlobalDefine.h"

#if !defined(CP_EXTERN)
#  if defined(__cplusplus)
#   define CP_EXTERN extern "C"
#  else
#   define CP_EXTERN extern
#  endif
#endif
//----------------------------------------------------------------------------------------------
CP_EXTERN id EncodeObjectFromDic(NSDictionary *dic, NSString *key);

CP_EXTERN id SafeObjectAtIndex(NSArray *arr, NSInteger index);

CP_EXTERN NSString     * EncodeStringFromDic(NSDictionary *dic, NSString *key);
CP_EXTERN NSString     * EncodeDefaultStrFromDic(NSDictionary *dic, NSString *key,NSString * defaultStr);

CP_EXTERN NSDictionary * EncodeDicFromDic(NSDictionary *dic, NSString *key);
CP_EXTERN NSArray      * EncodeArrayFromDic(NSDictionary *dic, NSString *key);

CP_EXTERN void EncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key);
CP_EXTERN void EncodeUnEmptyObjctToArray(NSMutableArray *arr,id object);
CP_EXTERN void EncodeDefaultStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key,NSString * defaultStr);
//----------------------------------------------------------------------------------------------

