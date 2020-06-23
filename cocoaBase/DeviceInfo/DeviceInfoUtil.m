//
//  InfoUtil.m
//  UtilSDK
//
//  Created by willwang on 2019/3/8.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "DeviceInfoUtil.h"
#import <UIKit/UIKit.h>
#import "SFHFKeychainUtils.h"
#import <OpenUDID.h>


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#define kKeychainServiceName (@"kcSUPAY")
@implementation DeviceInfoUtil

// 返回Bundle中的Version(不是Build)
+ (NSString *)bundleVersion{
    NSString *versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", versionNumber];
}

// 返回Bundle中的Version(不是Build)
+ (NSString *)buildNo{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * appBuildNo = [infoDictionary objectForKey:@"CFBundleVersion"];
    return appBuildNo;
}

+(NSString *)appName{
    
    NSDictionary * dicInfo =[[NSBundle mainBundle] infoDictionary];
    NSString * appNameStr =[dicInfo objectForKey:@"CFBundleName"]; //当前应用名称
    return appNameStr;
    
}
//手机名称
+(NSString *)userPhoneName{
    NSString *userPhoneNameStr = [[UIDevice currentDevice] name];//手机名称
    return userPhoneNameStr;
}
//手机系统版本号
+(NSString *)systemVersion{
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    return systemVersion;
}

+(NSString *)deviceModel{
    NSString *deviceModel = [[UIDevice currentDevice] model];
    return deviceModel;
}

+(NSString *)CPDeviceID{
    
    NSString* key = @"(_kcNewUDID)";
    // 从Keychain中寻找唯一标识符
    NSString* sUDID = [self getKeychain:key];
    
    // 如果Keychain中没有则从OpenUDID中获取，并存入Keychain
    // 判断UDID为空或者不是以iOS.开头的都要重新获取UDID
    if( sUDID.length == 0 || ![sUDID hasPrefix:@"i."] )
    {
        CFUUIDRef uuidStr = CFUUIDCreate(kCFAllocatorDefault);
        
        CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuidStr);
        
        NSString * uuid = [NSString stringWithFormat:@"%@", cfstring];
        sUDID = [@"i." stringByAppendingString:uuid];
        [self setKeychain:key value:sUDID];
    }
    
    // 设备代号
    NSString* model = @"";
    {
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char* machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        model = [model stringByReplacingOccurrencesOfString:@"," withString:@""];
        free(machine);
    }
    
    sUDID = [sUDID stringByAppendingString:model];
    return sUDID;
}

+(void) setKeychain:(NSString*)key value:(id)value
{
    if( !key ) return;
    if( !value ) value = @"";
    [SFHFKeychainUtils storeUsername:key
                         andPassword:value
                      forServiceName:kKeychainServiceName
                      updateExisting:YES
                               error:nil];
}
+(id) getKeychain:(NSString*)key
{
    if( !key ) return nil;
    return [SFHFKeychainUtils getPasswordForUsernameOld:key
                                      andServiceName:kKeychainServiceName
                                               error:nil];
}

+ (NSString*)osType {
    // 00 表示iOS; 01 表示安卓
    return @"00";
}

+ (NSString*)udid {
    return [OpenUDID value];
}

+ (NSString*)osManufacturer {
    return @"Apple";
}

+ (NSString*)osSystemState {
    // 1 表示正常系统；0 表示已越狱
    NSArray *array = @[@"/Applications/Cydia.app",
                       @"/bin/bash",
                       @"/usr/sbin/sshd",
                       @"Library/MobileSubstrate/MobileSubstrate.dylib",
                       @"/etc/apt"];
    for (int i = 0; i < array.count; i++) {
        NSString* filePathString = array[i];
        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePathString];
        if (fileExist) {
            return @"0";
        }
    }
    return @"1";
}

+ (NSString*)isEmulator {
    // 1 表示模拟器环境；0 表示真机环境
    #if TARGET_IPHONE_SIMULATOR  //模拟器
        return @"1";
    #elif TARGET_OS_IPHONE      //真机
        return @"0";
    
    #endif
}

+ (NSString*)bundleId {
    return [NSBundle mainBundle].bundleIdentifier;
}

+ (BOOL)isIphoneXSeries {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}


/*!
 *  @author Huibin Guo, 2016/01/12
 *  @brief 获取屏幕分辨率
 *  @return 屏幕分辨率
 */
+ (NSString *)screenResolution
{
    // 屏幕分辨率
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    CGFloat width = size_screen.width * scale_screen;
    CGFloat height = size_screen.height * scale_screen;
    NSString *screenResolution = [NSString stringWithFormat:@"%.0f * %.0f", width, height];
    return screenResolution;
}


+ (NSString *) MACaddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

@end
