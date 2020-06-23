//
//  NSString+3DES.h
//  UtilSDK
//
//  Created by willwang on 2019/3/21.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(TripleDES)

/**
 加密
 iOS系统库加密只支持kCCOptionPKCS7Padding | kCCOptionECBMode,
 @param key key
 @return 密文
 */
-(NSString *)encryptWithKey:(NSString *)key iv:(NSString *)iv;

/**
 解密
 
 @param key key
 @return 明文
 */
-(NSString *)decryptWithKey:(NSString *)key iv:(NSString *)iv;



@end

NS_ASSUME_NONNULL_END
