//
//  DeviceAuthorization.m
//
//  Created by user on 16/7/6.
//  Copyright © 2016年 . All rights reserved.
//

#import "DeviceAuthorization.h"
#import "AlertView.h"
@import AVFoundation;

@implementation CPDeviceAuthorization
/*!
 *  @author scott.lin, 16-07-06
 *
 *  @brief 获取设备是否授权权限
 *  @param avMediaType 设备类型
 *  @return 授权类型
 */
+(AVCamSetupResult)authorization:(NSString*)avMediaType{
    __block AVCamSetupResult setupResult = AVCamSetupResultSuccess;
    switch ( [AVCaptureDevice authorizationStatusForMediaType:avMediaType] )
    {
        case AVAuthorizationStatusAuthorized:
        {
            setupResult = AVCamSetupResultSuccess;
            // 允许授权
            break;
        }
        case AVAuthorizationStatusNotDetermined:
        {
            //没有授权
            [AVCaptureDevice requestAccessForMediaType:avMediaType completionHandler:^( BOOL granted ) {
                if ( ! granted ) {
                   setupResult = AVCamSetupResultNotAuthorized;
                }

            }];
            break;
        }
        default:
        {
            setupResult = AVCamSetupResultNotAuthorized;
            break;
        }
    }
    return setupResult;
}

/*!
 *  @author scott.lin, 16-07-06
 *
 *  @brief 获取授权失败的view
 *  @param avMediaType 设备类型
 */
+(void)getNotAuthorized:(NSString*)avMediaType{
    if (avMediaType != AVMediaTypeVideo && avMediaType != AVMediaTypeAudio) {
        return ;
    }
    
    NSString *message;
    NSString *title;
    if (avMediaType == AVMediaTypeVideo) {
        title = @"打开相机";
        message = @"请在【设置】-【隐私】-【相机】中将此软件设为开启";
    }
    if (avMediaType == AVMediaTypeAudio){
        title = @"打开麦克风";
        message = @"请在【设置】-【隐私】-【麦克风】中将此软件设为开启";
    }
  
    
    [[AlertView shareInstance]showAlertViewWithTitle:title message:message cancleButtonTitle:@"确定" okButtonTitle:@"取消" clickHandle:^(NSInteger index) {
        if (index == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    
}

+(void)requestAlbumAuth
{
  
  [[AlertView shareInstance]showAlertViewWithTitle:@"打开相册" message:@"请在【设置】-【隐私】-【照片】中将此软件设为开启"  cancleButtonTitle:@"确定" okButtonTitle:@"取消" clickHandle:^(NSInteger index) {
    if (index == 0) {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
    
  }];
}

@end
