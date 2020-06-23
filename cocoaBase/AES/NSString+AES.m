//
//  NSString+AES256.m
//  PocTest
//
//  Created by will on 15/12/24.
//  Copyright © 2015年 will. All rights reserved.
//

#import "NSString+AES.h"
#import "Base64.h"
#import "NSData+AES.h"
#import "GlobalDefine.h"

@implementation NSString(AES)

-(NSString *) aes256_encrypt:(NSString *)key
{
    if (IsStrEmpty(key)) {
        return @"";
    }
    //const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //对数据进行加密
    NSData *result = [data aes256_encrypt:key];
    if (result && result.length > 0) {
        return [Base64 base64StringFromData:result];
    }
    return @"";
}

-(NSString *) aes256_decrypt:(NSString *)key
{
    if (IsStrEmpty(key)) {
        return @"";
    }
    NSData *data = [Base64 base64DataFromString:self];
    
    //对数据进行解密
    NSData* result = [data aes256_decrypt:key];
    NSString *resultStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    if (resultStr && result.length > 0) {
        
        return resultStr;
    }
    return @"";
}
-(NSString *) aes128_encrypt:(NSString *)key
{
    if (IsStrEmpty(key)) {
        return @"";
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //对数据进行加密
    NSData *result = [data aes128_encrypt:key];
    if (result && result.length > 0) {
        return [Base64 base64StringFromData:result];
    }
    return @"";
}

-(NSString *) aes128_decrypt:(NSString *)key
{
    if (IsStrEmpty(key)) {
        return @"";
    }
    
    NSData *data = [Base64 base64DataFromString:self];
    
    //对数据进行解密
    NSData* result = [data aes128_decrypt:key];
    
    NSString *resultStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    if (resultStr && result.length > 0) {
        
        return resultStr;
    }
    return @"";
}

@end
