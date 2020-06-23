//
//  NetInfoUtil.h
//  FruitBase
//
//  Created by develop on 2019/4/15.
//  Copyright © 2019 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetInfoUtil : NSObject

/*!
 *  @author Huibin Guo, 2016/01/12
 *  @brief 判断网络类型
 *  @return 网络类型
 */
+ (NSString*)networkType;

// 获取网络制式
+ (NSString*)getRadioAccessType;

/**
 网络信号强度

 @return 网络信号强度
 */
+ (NSString*)signalRate;

/**
 IPv4

 @return IPv4
 */
+ (NSString*)getIpv4;

/**
 IPv6

 @return IPv6
 */
+ (NSString*)getIpv6;

/**
 是否开启代理

 @return 是否开启代理
 */
+ (NSString*)isNetProxy;

/**
 是否开启VPN

 @return 是否开启VPN
 */
+ (NSString*)isNetVpn;

/**
 wifi名称

 @return wifi名称
 */
+ (NSString*)wifiSsid;

/**
 网络是否连接

 @return 网络是否连接
 */
+ (BOOL)isConnectedNetwork;

/**
 基站信息

 @return  基站信息
 */
+ (NSString*)bsDefault;


/**
 领区基站信息

 @return 领区基站信息
 */
+ (NSArray*)bsNeighboring;

@end

NS_ASSUME_NONNULL_END
