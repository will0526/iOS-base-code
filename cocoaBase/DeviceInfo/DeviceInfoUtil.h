//
//  InfoUtil.h
//  UtilSDK
//
//  Created by willwang on 2019/3/8.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 设备信息，版本信息获取
 */
@interface DeviceInfoUtil : NSObject


/**
 应用版本号

 @return 应用版本号
 */
+ (NSString *)bundleVersion;


/**
 应用build号

 @return 应用build号
 */
+ (NSString *)buildNo;


/**
 应用名称

 @return 应用名称
 */
+(NSString *)appName;

/**
 手机名称

 @return 手机名称
 */
+(NSString *)userPhoneName;

//手机系统版本号

/**
 系统版本号

 @return 系统版本号
 */
+(NSString *)systemVersion;

/**
 设备类型

 @return 设备类型
 */
+(NSString *)deviceModel;


/**
 汇付唯一识别号

 @return 汇付唯一识别号
 */
+(NSString *)CPDeviceID;


/**
 系统类型

 @return 系统类型
 */
+ (NSString*)osType;

/**
 UDID

 @return UDID
 */
+ (NSString*)udid;

/**
 设备制造商

 @return 设备制造商
 */
+ (NSString*)osManufacturer;

/**
 越狱状态，1 表示正常系统；0 表示已越狱

 @return 越狱状态
 */
+ (NSString*)osSystemState;

/**
 是否为模拟器 1 表示模拟器环境；0 表示真机环境

 @return  是否为模拟器
 */
+ (NSString*)isEmulator;


/**
 bundleID

 @return bundleId
 */
+ (NSString*)bundleId;


/**
 是否为iPhoneX系列

 @return 是否为iPhoneX系列
 */
+ (BOOL)isIphoneXSeries;

/*!
 *  @author Huibin Guo, 2016/01/12
 *  @brief 获取屏幕分辨率
 *  @return 屏幕分辨率
 */
+ (NSString *)screenResolution;


/**
 mac 地址

 @return mac 地址
 */
+ (NSString *) MACaddress;

@end

NS_ASSUME_NONNULL_END
