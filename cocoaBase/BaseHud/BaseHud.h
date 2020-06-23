//
//  BaseHud.h
//  FruitBase
//
//  Created by willwang on 2020/6/23.
//  Copyright © 2020 com.will. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BaseHud : NSObject

+(void) popSuccess:(NSString*)message;
+(void) popError:(NSString*)message;

+(void) popWaiting;
+(void) popWaiting:(NSString*)hint;
+(void) popWaiting:(NSString*)hint userInteractionEnabled:(BOOL)userInteractionEnabled;
+(void) dismissWaiting;

@end

NS_ASSUME_NONNULL_END


NS_INLINE void popWaiting(){
    dispatch_async(dispatch_get_main_queue(), ^{
        [BaseHud popWaiting];
    });
    
}
NS_INLINE void popWaitingWithHint(NSString* hint){[BaseHud popWaiting:hint];}
NS_INLINE void popWaitingWithHintAndUserInteraction(NSString* hint, BOOL userInteractionEnabled){[BaseHud popWaiting:hint
                                                                                          userInteractionEnabled:userInteractionEnabled];}
NS_INLINE void dismissWaiting(){
    dispatch_async(dispatch_get_main_queue(), ^{
        [BaseHud dismissWaiting];
    });
}
NS_INLINE void popSuccess(NSString* message){[BaseHud popSuccess:message];}
NS_INLINE void popError(NSString* message){[BaseHud popError:message];}

