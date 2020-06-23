//
//  ImageUtils.m
//  LiteProject
//
//  Created by willwang on 2018/12/18.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "ImageUtils.h"
#import "Base64.h"
@implementation ImageUtils

/*!
 @author xuewei.zhang, 16/14/09
 
 @brief image图片转化成base64字符串
 @param image    要转化的image
 @return base64字符串
 @since 1.6.0
 */
+(NSString *)base64StringByImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)imageSize width:(CGFloat)width height:(CGFloat)height{
    
    UIImage * newImage = [ImageUtils compressImage:image maxDataSize:imageSize width:width height:height];
    
    NSString *imageBase64Str = @"";
    //转Base64
    if (newImage) {
        imageBase64Str = [Base64 base64EncodedImageFrom:newImage];
    }
    return imageBase64Str;
}


+(UIImage *)compressImage:(UIImage *)image maxDataSize:(CGFloat)imageSize width:(CGFloat)width height:(CGFloat)height{
    
    if (!image) {
        return nil;
    }
    if (imageSize<1) {
        return nil;
    }
    
    if (width<1) {
       return nil;
    }
    
    if (height<1) {
        return nil;
    }
    
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    
    if (!data) {
        return nil;
    }
    
    if (data.length <= imageSize*1024) {
        return image;
    }
    //调整方向
    UIImage *newimage = [ImageUtils fixOrientation:image];
    //    压缩尺寸
    newimage = [ImageUtils imageWithImage:newimage scaledToSize:CGSizeMake(width, height)];
    //    压缩大小
    newimage = [ImageUtils compressImageQuality:newimage toByte:imageSize*1024];
    
    return newimage;
  
}


+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
  if (!image) {
    return nil;
  }
  CGSize aimSize = image.size;
  
  if( aimSize.height > newSize.height )
  {
    aimSize.width = newSize.height * image.size.width / image.size.height;
    aimSize.height = newSize.height;
  }
  if( aimSize.width > newSize.width )
  {
    aimSize.height = newSize.width * image.size.height / image.size.width;
    aimSize.width = newSize.width;
  }
  // Create a graphics image context
  UIGraphicsBeginImageContext(aimSize);
  
  // Tell the old image to draw in this new context, with the desired
  // new size
  [image drawInRect:CGRectMake(0,0,aimSize.width,aimSize.height)];
  
  // Get the new image from the context
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  
  // End the context
  UIGraphicsEndImageContext();
  
  // Return the new image.
  return newImage;
}

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
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
  
  if (!image) {
    return nil;
  }
  
  CGFloat compression = 1;
  NSData *data = UIImageJPEGRepresentation(image,0.8);
  if (data.length < maxLength) return image;
  CGFloat max = 1;
  CGFloat min = 0;
  for (int i = 0; i < 7; ++i) {
    compression = (max + min) / 2;
    data = UIImageJPEGRepresentation(image, compression);
    NSLog(@"compression:%f .....data,length:%lu",compression,(unsigned long)data.length);
    if (data.length < maxLength) {
      min = compression;
    } else if (data.length > maxLength) {
      max = compression;
    } else {
      break;
    }
  }
  UIImage *resultImage = [UIImage imageWithData:data];
  return resultImage;
}

/**
 调整图片方向
 
 @param aImage 图片
 @return 调整后图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
  
  if (!aImage) {
    return nil;
  }
  // No-op if the orientation is already correct
  if (aImage.imageOrientation == UIImageOrientationUp)
    return aImage;
  
  // We need to calculate the proper transformation to make the image upright.
  // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  switch (aImage.imageOrientation) {
    case UIImageOrientationDown:
    case UIImageOrientationDownMirrored:
      transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
      transform = CGAffineTransformRotate(transform, M_PI);
      break;
      
    case UIImageOrientationLeft:
    case UIImageOrientationLeftMirrored:
      transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
      transform = CGAffineTransformRotate(transform, M_PI_2);
      break;
      
    case UIImageOrientationRight:
    case UIImageOrientationRightMirrored:
      transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
      transform = CGAffineTransformRotate(transform, -M_PI_2);
      break;
    default:
      break;
  }
  
  switch (aImage.imageOrientation) {
    case UIImageOrientationUpMirrored:
    case UIImageOrientationDownMirrored:
      transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
      transform = CGAffineTransformScale(transform, -1, 1);
      break;
      
    case UIImageOrientationLeftMirrored:
    case UIImageOrientationRightMirrored:
      transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
      transform = CGAffineTransformScale(transform, -1, 1);
      break;
    default:
      break;
  }
  
  // Now we draw the underlying CGImage into a new context, applying the transform
  // calculated above.
  CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                           CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                           CGImageGetColorSpace(aImage.CGImage),
                                           CGImageGetBitmapInfo(aImage.CGImage));
  CGContextConcatCTM(ctx, transform);
  switch (aImage.imageOrientation) {
    case UIImageOrientationLeft:
    case UIImageOrientationLeftMirrored:
    case UIImageOrientationRight:
    case UIImageOrientationRightMirrored:
      // Grr...
      CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
      break;
      
    default:
      CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
      break;
  }
  
  // And now we just create a new UIImage from the drawing context
  CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
  UIImage *img = [UIImage imageWithCGImage:cgimg];
  CGContextRelease(ctx);
  CGImageRelease(cgimg);
  return img;
}


@end
