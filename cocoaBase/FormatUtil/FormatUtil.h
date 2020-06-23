//
//  AmountUtil.h
//  UtilSDK
//
//  Created by willwang on 2019/3/6.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN



/**
 格式化数据，金额，银行卡号等
 */
@interface FormatUtil : NSObject

/**
 将以分为单位的金额转换成#,###.##的金额格式

 @param money 金额
 @return 转换后的金额
 */
+(NSString *)amountWithComma:(NSString *)money;



/**
 单位转换

 @param amount 待转金额
 @param type 1,元转分; 0,分转元
 @return 结果
 */
+(NSString *)transMoneyUnit:(NSString *)amount type:(int)type;

/**
 字符串加掩码

 @param string 待转换字符串
 @param range 掩码范围
 @param mask 掩码字符串
 @return 掩码后的字符串
 */
+ (NSString *)formatStringWithMask:(NSString *)string range:(NSRange )range Mask:(NSString *)mask;

/**
 字符串插入空格
 
 @param string 待转换字符串
 @param space 间隔位数
 @return 转换后字符串
 */
+(NSString *) formatStringWithBlank:(NSString *)string SpaceNum:(int)space;


@end

NS_ASSUME_NONNULL_END
