//
//  NSString+RSA.h
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


NS_ASSUME_NONNULL_BEGIN

@interface RSAUtil : NSObject


/**
 公钥钥加密data，补位模式默认为kSecPaddingPKCS1

 @param data 明文
 @param pubKey 公钥
 @return 密文data
 */
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

/**
 私钥加密data，补位模式默认为kSecPaddingPKCS1

 @param data 明文
 @param privKey 私钥
 @return 密文
 */
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;


/**
 公钥解密 data，补位模式默认为kSecPaddingPKCS1
 
 @param data 密文
 @param pubKey 公钥
 @return 明文
 */
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

/**
 私钥钥解密 data，补位模式默认为kSecPaddingPKCS1
 
 @param data 密文
 @param privKey 公钥
 @return 明文
 */
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

#pragma mark 带padding模式

/**
 公钥钥加密data
 
 @param data 明文
 @param pubKey 公钥
 @param paddingType 补位模式
 @return 密文data
 */
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey padding:(SecPadding)paddingType;

/**
 私钥加密data
 
 @param data 明文
 @param privKey 私钥
 @param paddingType 补位模式
 @return 密文
 */
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey padding:(SecPadding)paddingType;

/**
 公钥解密 data
 
 @param data 密文
 @param pubKey 公钥
 @param paddingType 补位模式
 @return 明文
 */
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey padding:(SecPadding)paddingType;

/**
 私钥钥解密 data
 
 @param data 密文
 @param privKey 公钥
 @param paddingType 补位模式
 @return 明文
 */
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey padding:(SecPadding)paddingType;



@end

NS_ASSUME_NONNULL_END
