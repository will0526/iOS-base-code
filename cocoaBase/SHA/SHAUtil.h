//
//  SHAUtil.h
//  UtilSDK
//
//  Created by willwang on 2019/3/22.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHAUtil : NSObject

/**
 sha1签名

 @param string 明文
 @return 签名
 */
+(NSString *)signSha1:(NSString *)string;


/**
 sha256签名

 @param string 明文
 @return 签名
 */
+(NSString *)signSha256:(NSString *)string;


/**
 HmacSha256

 @param string 明文
 @param key key
 @return 签名
 */
+(NSString *)signHmacSha256:(NSString *)string key:(NSString *)key;



@end

NS_ASSUME_NONNULL_END
