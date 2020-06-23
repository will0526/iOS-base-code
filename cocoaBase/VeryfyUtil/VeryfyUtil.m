//
//  VeryfyUtil.m
//  UtilSDK
//
//  Created by willwang on 2019/3/7.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "VeryfyUtil.h"
#import "GlobalDefine.h"
@implementation VeryfyUtil

+(BOOL)regularVerfy:(NSString *)regular withStr:(NSString *)str{
    
    if (IsStrEmpty(regular) || IsStrEmpty(str)) {
        return NO;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [pred evaluateWithObject:str];
}

@end
