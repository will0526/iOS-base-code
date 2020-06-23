//
//  UIView+Extension.h
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)


/**
 视图左侧坐标
 */
@property(nonatomic) CGFloat left;

/**
 视图顶部坐标
 */
@property(nonatomic) CGFloat top;

/**
 视图右侧坐标
 */
@property(nonatomic) CGFloat right;

/**
 视图底部坐标
 */
@property(nonatomic) CGFloat bottom;


/**
 视图宽
 */
@property(nonatomic) CGFloat width;

/**
 视图高
 */
@property(nonatomic) CGFloat height;


/**
 视图中心X
 */
@property(nonatomic) CGFloat centerX;

/**
 视图中心Y
 */
@property(nonatomic) CGFloat centerY;

//@property(nonatomic,readonly) CGFloat screenX;
//@property(nonatomic,readonly) CGFloat screenY;
//@property(nonatomic,readonly) CGFloat screenViewX;
//@property(nonatomic,readonly) CGFloat screenViewY;
//@property(nonatomic,readonly) CGRect screenFrame;


/**
 视图origin
 */
@property(nonatomic) CGPoint origin;

/**
 视图size
 */
@property(nonatomic) CGSize size;



/**
 移除所有子视图
 */
- (void)removeAllSubviews;


/**
 获取当前view的所在VC

 @return VC
 */
- (UIViewController *)viewController;


@end
NS_ASSUME_NONNULL_END
