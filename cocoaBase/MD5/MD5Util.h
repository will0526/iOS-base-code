//
//  NSString+MD5.h
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MD5Util: NSObject

/**
 对字符串md5签名，返回16位签名，大写
 
 @param str 字符串
 @return 16位签名字符串
 */
+(NSString *)md5_16:(NSString *)str;

/**
 对字符串md5签名，返回32位签名，大写
 
 @param str 字符串
 @return 32位签名字符串
 */
+(NSString *)md5_32:(NSString *)str;

/**
 对文件md5签名，返回16位签名，大写
 
 @param filePath 文件路径
 @return 16位签名字符串
 */
+(NSString *)md5File_16:(NSString *)filePath;

/**
 对文件md5签名，返回32位签名，大写

 @param filePath 文件路径
 @return 32位签名字符串
 */
+(NSString *)md5File_32:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
