//
//  NSString+MD5.m
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "MD5Util.h"
#import "GlobalDefine.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Util


+(NSString *)md5_32:(NSString *)str{
    if (IsStrEmpty(str)) {
        return @"";
    }
    
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
    
}

+(NSString *)md5_16:(NSString *)str{
    
    if (IsStrEmpty(str)) {
        return @"";
    }
    NSString *reslut32 = [MD5Util md5_32:str];
    
    if (reslut32) {
        return [reslut32 substringWithRange:NSMakeRange(8, 16)];
    }
    return @"";
    
}

+(NSString *)md5File_16:(NSString *)filePath{
    
    if (IsStrEmpty(filePath)) {
        return @"";
    }
    NSString *reslut32 = [MD5Util md5File_32:filePath];
    
    if (reslut32) {
        return [reslut32 substringWithRange:NSMakeRange(8, 16)];
    }
    return @"";
    
}



+(NSString *)md5File_32:(NSString *)filePath{
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if( handle == nil ) {
        NSLog(@"文件出错");
        return @"";
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

@end
