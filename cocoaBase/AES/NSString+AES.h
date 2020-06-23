//
//  NSString+AES256.h
//  PocTest
//
//  Created by will on 15/12/24.
//  Copyright © 2015年 will. All rights reserved.
//

//
//NSString +AES256.h
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString(AES)

/**
 aes 256加密
 
 @param key key
 @return 密文
 */
-(NSString *) aes256_encrypt:(NSString *)key;

/**
 aes 256 解密
 
 @param key key
 @return 明文data
 */
-(NSString *) aes256_decrypt:(NSString *)key;

/**
 aes128加密
 
 @param key key
 @return 密文
 */
-(NSString *) aes128_encrypt:(NSString *)key;

/**
 aes128解密
 
 @param key key
 @return 明文
 */
-(NSString *) aes128_decrypt:(NSString *)key;
@end
