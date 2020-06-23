//
//  AlertView.h
//
//  Created by will on 2018/7/10.
//  Copyright © 2018年 will. All rights reserved.
//

#import <UIKit/UIKit.h>

//回调 block
typedef void (^ClickedHandle)(NSInteger index);


/**
 * @author yingyong.wang
 * @date 2018/7/10
 * @brief 为了使 SDK 内，object 对象里可以监听 alert 的点击事件。需实现一个单例，保持对象不释放。故实现此类。
 */
@interface AlertView : NSObject

+ (AlertView *)shareInstance;

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle clickHandle:(ClickedHandle) handle;


@end
