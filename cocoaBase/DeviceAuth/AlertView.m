//
//  AlertView
//
//  Created by will on 2018/7/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "AlertView.h"


@interface AlertView ()
@property (nonatomic, weak)ClickedHandle  clickBlock;
@end

@implementation AlertView

+ (AlertView *)shareInstance{
    static AlertView * instance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[AlertView alloc] init];
        }
    });
    return instance;
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle clickHandle:(ClickedHandle) handle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle && ![cancelTitle isEqualToString:@""]) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了按钮1，进入按钮1的事件");
            if (handle) {
                handle(1);
            }
        }];
        [alert addAction:action1];
    }
    
    if (okTitle && ![okTitle isEqualToString:@""]) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handle) {
                handle(0);
            }
        }];
        [alert addAction:action2];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController* rootNav = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootNav presentViewController:alert animated:YES completion:nil];
    });
    
}



@end
