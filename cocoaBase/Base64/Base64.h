
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <UIKit/UIKit.h>
#import "SafeValueUtil.h"

@interface Base64 : NSObject


/**
 图片转base64字符串

 @param image 图片
 @return base64字符串
 */
+ (NSString *)base64EncodedImageFrom:(UIImage *)image;



/**
 base64字符串转图片

 @param base64 字符串图片
 @return 图片
 */
+ (UIImage *)imageWithBase64String:(NSString *)base64;


/**
 字符串编码base64

 @param text 明文
 @return 编码后base64
 */
+ (NSString *)base64StringFromText:(NSString *)text;


/**
 base64字符串解码

 @param base64 字符串
 @return 解码后字符串
 */
+ (NSString *)textFromBase64String:(NSString *)base64;


/**
 base64字符串转data

 @param string base64
 @return data
 */
+ (NSData *)base64DataFromString:(NSString *)string;


/**
 data 转base64字符串

 @param data data
 @return 字符串
 */
+ (NSString *)base64StringFromData:(NSData *)data;

@end
