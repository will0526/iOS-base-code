//
//  NetInfoUtil.m
//  FruitBase
//
//  Created by develop on 2019/4/15.
//  Copyright © 2019 com.will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetInfoUtil.h"
#import "Reachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "DeviceInfoUtil.h"
#import <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "JSON.h"
#import "GlobalDefine.h"

@implementation NetInfoUtil

+ (NSString*)networkType
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            // 无网络连接
            return @"0";
            break;
        case ReachableViaWiFi:
            // 网络连接为WiFi
            return @"2";
            break;
        case ReachableViaWWAN:
            // 网络连接为手机网络
            return @"1";
            break;
    }
}

+ (NSString*)getRadioAccessType {
    CTTelephonyNetworkInfo* info = [[CTTelephonyNetworkInfo alloc] init];
    return info.currentRadioAccessTechnology;
}

+ (NSString*)getIpv4 {
    return [NetInfoUtil getIPAddress:YES];
}

+ (NSString*)getIpv6 {
    return [NetInfoUtil getIPAddress:NO];
}

+ (NSString *)getIPAddress: (BOOL)isIpv4 {
    NSString *wifiAddress = @"";
    NSString *cellAddress = @"";
    struct ifaddrs *interfaces = NULL;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface = interfaces; interface; interface = interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP)) {
                continue; // deeply nested code harder to read
            }
            
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            sa_family_t sa_type = addr->sin_family;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
            if (sa_type && (sa_type == AF_INET || sa_type == AF_INET6)) {
                NSString *type;
                if (isIpv4) {
                    inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN);
                    type = @"ipv4";
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN);
                    type = @"ipv6";
                }
                if([name isEqualToString:@"en0"]) {
                    // en0:Interface is the wifi connection on the iPhone;
                    wifiAddress = [NSString stringWithUTF8String:addrBuf];
                } else if ([name isEqualToString:@"pdp_ip0"]) {
                    // pdp_ip0: cell connection
                    cellAddress = [NSString stringWithUTF8String:addrBuf];
                }
                NSLog(@"NAME: \"%@\%@\" addr: %@", name, type,[NSString stringWithUTF8String:addrBuf]);
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSLog(@"NAME: \"wifi\" addr: %@", wifiAddress);
    NSLog(@"NAME: \"cell\" addr: %@", cellAddress);

    NSString *addr = IsStrEmpty(wifiAddress)? cellAddress : wifiAddress;
    NSLog(@"final addr: %@", addr);

    return IsStrEmpty(addr) ? @"" : addr;
}

+ (NSString*)isNetProxy {
    // 0表示没有设置代理. 1表示设置了代理
    NSDictionary *proxySettings =  (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    
    NSLog(@"%@", proxySettings);
    
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        NSLog(@">>>>>>没有设置代理");
        return @"0";
    }else{
        NSLog(@">>>>>>设置了代理");
        return @"1";
    }
}

+ (NSString*)isNetVpn {
    NSDictionary * proxySettings = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    
    NSLog(@"%@", proxySettings);
    
    NSArray * keys = [proxySettings[@"__SCOPED__"] allKeys];
    for (NSString * key in keys) {
        if ([key rangeOfString:@"tap"].location != NSNotFound ||
            [key rangeOfString:@"tun"].location != NSNotFound ||
            [key rangeOfString:@"ppp"].location != NSNotFound) {
            NSLog(@">>>>>>开启了VPN");
            return @"1";
        }
    }
    NSLog(@">>>>>>没有开启VPN");
    return @"0";
}

// ios12中，需要在Capabilities -> Access WiFi Information -> ON 打开开关才能获取
+ (NSString*)wifiSsid {
    NSString *ssid = @"";
    NSArray * ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString* ifnam in ifs) {
        NSDictionary* info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}


#pragma mark - 获取网络信号强度
+ (NSString*)signalRate {
    if (![NetInfoUtil isConnectedNetwork]) {
        return @"";
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = [app valueForKey:@"statusBar"];
    NSString *signalStrength = @"";
    if ([DeviceInfoUtil isIphoneXSeries]) {
        //iPhone X
        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [[foregroundView subviews][2] subviews];
        // 非WIFI
        if ([[NetInfoUtil networkType] isEqualToString:@"1"]) {
            for (id subview in subviews) {
                if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarCellularSignalView")]) {
                    signalStrength = [NSString stringWithFormat:@"%@",
                                      [subview valueForKey:@"_numberOfActiveBars"]];
                }
            }
        }
        // WIFI
        if ([[NetInfoUtil networkType] isEqualToString:@"2"]) {
            for (id subview in subviews) {
                if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                    signalStrength = [NSString stringWithFormat:@"%@",
                                      [subview valueForKey:@"_numberOfActiveBars"]];
                }
            }
        }
    } else {
        NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
        NSString *dataNetworkItemView = nil;
        //WiFi
        if ([[NetInfoUtil networkType] isEqualToString:@"2"]) {
            for (id subview in subviews) {
                if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                    dataNetworkItemView = subview;
                    signalStrength = [NSString stringWithFormat:@"%@",
                                      [dataNetworkItemView valueForKey:@"_wifiStrengthBars"]];
                    break;
                }

            }
        }
        //非WIFI
        if ([[NetInfoUtil networkType] isEqualToString:@"1"]) {
            for (id subview in subviews) {
                if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
                    dataNetworkItemView = subview;
                    signalStrength = [NSString stringWithFormat:@"%@",
                                      [dataNetworkItemView valueForKey:@"_signalStrengthBars"]];
                    break;
                }
            }
        }
    }
    return signalStrength;
}

#pragma mark - 检查当前是否连网
+ (BOOL)isConnectedNetwork {
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;//IP地址
    
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}

+ (NSString*)bsDefault {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSMutableDictionary* carrierDictionary = [NSMutableDictionary dictionary];
    if (@available(iOS 12.0, *)) {
        NSDictionary* carriers = [info serviceSubscriberCellularProviders];
        for (CTCarrier* carrier in carriers.allValues) {
            [carrierDictionary setValue:carrier.mobileCountryCode forKey:@"mcc"]; // 国家码
            [carrierDictionary setValue:carrier.mobileNetworkCode forKey:@"mnc"]; // 网络码
        }
    } else {
        CTCarrier* carrier = [info subscriberCellularProvider];
        carrierDictionary[@"mcc"] = [carrier mobileCountryCode];
        carrierDictionary[@"mnc"] = [carrier mobileNetworkCode];
    }
    return [carrierDictionary JSONString];
}

+ (NSArray*)bsNeighboring {
    return @[];
}



@end
