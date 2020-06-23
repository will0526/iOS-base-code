//
//  NSString+3DES.m
//  UtilSDK
//
//  Created by willwang on 2019/3/21.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "NSString+3DES.h"
#import "NSData+3DES.h"
#import "GlobalDefine.h"
#import "Base64.h"

@implementation NSString(TripleDES)

-(NSString *)encryptWithKey:(NSString *)key iv:(NSString *)iv{
    if (IsStrEmpty(key)) {
        return @"";
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [data encryptWithKey:key iv:iv];
    if (result && result.length > 0) {
        return [Base64 base64StringFromData:result];
    }
    return @"";
}

-(NSString *)decryptWithKey:(NSString *)key iv:(NSString *)iv{
    if (IsStrEmpty(key)) {
        return @"";
    }
    NSData *data = [Base64 base64DataFromString:self];
    NSData *result = [data decryptWithKey:key iv:iv];
    
    if (result && result.length > 0) {
        return [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    }
    return @"";
}



@end
