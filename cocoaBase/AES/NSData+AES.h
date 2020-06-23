//
//  NSData+AES256.h
//  PocTest
//
//  Created by will on 15/12/24.
//  Copyright © 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSData(AES)

/**
 aes 256加密

 @param key key
 @return 密文
 */
-(NSData *) aes256_encrypt:(NSString *)key;

/**
 aes 256 解密

 @param key key
 @return 明文data
 */
-(NSData *) aes256_decrypt:(NSString *)key;

/**
 aes128加密

 @param key key
 @return 密文
 */
-(NSData *) aes128_encrypt:(NSString *)key;

/**
 aes128解密

 @param key key
 @return 明文
 */
-(NSData *) aes128_decrypt:(NSString *)key;






@end
