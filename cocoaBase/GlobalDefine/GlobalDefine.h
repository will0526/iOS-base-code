//
//  GlobalDefine.h
//  FruitBase
//
//  Created by willwang on 2019/4/29.
//  Copyright © 2019 com.will. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h



#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   ((nil == (_ref)) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ![(_ref) isKindOfClass:[NSString class]] ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || (![(_ref) isKindOfClass:[NSArray class]]) ||([(_ref) count] == 0))

#define SAFE_VALUE(_ref)     ([_ref isKindOfClass:[NSNull class]])?nil:_ref

#define SAFE_COPY(_ref)     SAFE_VALUE(_ref)?_ref:@""


#endif /* GlobalDefine_h */


#ifndef __OPTIMIZE__

# define NSLog(...) NSLog(__VA_ARGS__)

#else

#define NSLog(...) {}

#endif
