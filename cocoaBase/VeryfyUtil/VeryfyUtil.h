//
//  VeryfyUtil.h
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VeryfyUtil : NSObject

+(BOOL)regularVerfy:(NSString *)regular withStr:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
