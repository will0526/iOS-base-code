//
//  ImageUtils.h
//  LiteProject
//
//  Created by willwang on 2018/12/18.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ImageUtils : NSObject


/**
 按图片大小以及尺寸进行压缩
 
 @param image 待压缩图片
 @param imageSize 目标大小 单位kb
 @param width 宽
 @param height 高
 @return 压缩后新图片
 */
+(UIImage *)compressImage:(UIImage *)image maxDataSize:(CGFloat)imageSize width:(CGFloat)width height:(CGFloat)height;

/**
 按图片大小压缩图片到指定大小，转成base64输出

 @param image 待压缩图片
 @param imageSize 压缩大小，小于1，原图返回，不压缩
 @return 图片base64 string
 */
+(NSString *)base64StringByImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)imageSize width:(CGFloat)width height:(CGFloat)height;


/**
 压缩图片质量，
 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。
 最多压缩 6 次，1/(2^6) = 0.015625 < 0.02，也能达到每次循环 compression 减小 0.02 的效果。
 这样的压缩次数比循环减小 compression 少，耗时短。需要注意的是，当图片质量低于一定程度时，继续压缩没有效果。
 也就是说，compression 继续减小，data 也不再继续减小。
 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。
 
 @param image 待压缩图片
 @param maxLength 目标大小
 @return 新图片
 */
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
