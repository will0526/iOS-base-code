//
//
//  Created by user on 16/7/6.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM( NSInteger, AVCamSetupResult ) {
    AVCamSetupResultSuccess,
    AVCamSetupResultNotAuthorized,
    AVCamSetupResultSessionConfigurationFailed
};

@interface CPDeviceAuthorization : NSObject
/*!
 *  @author scott.lin, 16-07-06
 *
 *  @brief 获取设备是否授权权限
 *  @param avMediaType 设备类型
 *  @return 授权类型
 */
+(AVCamSetupResult)authorization:(NSString*)avMediaType;

/*!
 *  @author scott.lin, 16-07-06
 *
 *  @brief 获取授权失败的view
 *  @param avMediaType 设备类型
 */
+(void)getNotAuthorized:(NSString*)avMediaType;



/**
 请求相册权限
 */
+(void)requestAlbumAuth;

@end
