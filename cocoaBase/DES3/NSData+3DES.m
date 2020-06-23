//
//  NSData+3DES.m
//  UtilSDK
//
//  Created by willwang on 2019/3/22.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "NSData+3DES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GlobalDefine.h"
#import "Base64.h"

@implementation NSData(TripleDES)


//
-(NSData *)encryptWithKey:(NSString *)key iv:(NSString *)iv{
    if (IsStrEmpty(key)) {
        return nil;
    }
    
    NSData *encryptData = [NSData DES3Encrypt:self Withkey:key iv:iv];
    if (!encryptData) {
        return nil;
    }
    return encryptData;
}

-(NSData *)decryptWithKey:(NSString *)key iv:(NSString *)iv{
    if (IsStrEmpty(key)) {
        return nil;
    }
    
    NSData *data = [NSData DES3Decrypt:self withKey:key iv:iv];
    return data;
    
}


+ (NSData *)DES3Encrypt:(NSData *)data Withkey:(NSString *)key iv:(NSString *)iv {
//    NSData* data = [plantText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    size_t keyLen = key.length;
    char vKey[24] = {0};
    memcpy(vKey, [key UTF8String], (keyLen > 24) ? 24 : keyLen);
    const void *vinitVec;
    if (!IsStrEmpty(iv)) {
        vinitVec = (const void *) [iv UTF8String];;
    }
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vKey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//
//    NSString *result = [Base64 base64StringFromData:myData];
    return myData;
}

+ (NSData *)DES3Decrypt:(NSData *)encryptData withKey:(NSString *)key iv:(NSString *)iv{
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    size_t keyLen = key.length;
    char vKey[24] = {0};
    memcpy(vKey, [key UTF8String], (keyLen > 24) ? 24 : keyLen);
    
    const void *vinitVec;
    if (!IsStrEmpty(iv)) {
        vinitVec = (const void *) [iv UTF8String];;
    }
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vKey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    return [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
//                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
//    return result;
}





@end

