//
//  UIColor+Extension.h
//  FruitBase
//
//  Created by willwang on 2019/4/29.
//  Copyright © 2019 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

#undef    HEX_RGB
#define HEX_RGB(V)   [UIColor hexStringToColor:V]


@interface UIColor(Extension)


#pragma mark - 颜色相关
//十六进制颜色字符串转UIColor

/**
 字符串转颜色

 @param stringToConvert 十六进制颜色值
 @return 颜色对象
 */
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;



/**
 十六进制支付串转颜色

 @param stringToConvert 十六进制颜色
 @param alpha 透明度
 @return 颜色对象
 */
+(UIColor *) hexStringToColor: (NSString *) stringToConvert alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
