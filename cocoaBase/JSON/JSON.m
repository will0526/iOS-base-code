//
//  JSON.m
//  SUPAY
//
//  Created by will on 15/9/21.
//  Copyright (c) 2015年 will.com. All rights reserved.
//

#import "JSON.h"

NSString* jsonString(id object)
{
    if( !object )
    {
        return @"";
    }
    
    NSError* error = nil;
    NSData* jsonData = nil;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                   options:0
                                                     error:&error];
    } @catch (NSException *exception) {
        return @"";
    }
    
    if( error )
    {
        NSLog(@"json encode error: %@", error);
        return @"";
    }
    
    NSString* strRet = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if( !strRet )
    {
        NSLog(@"json encode error: %s length: %d", [jsonData bytes], (int)[jsonData length]);
        return @"";
    }
    return strRet;
}

id objectFromJSONString(NSString* jsonString)
{
    if( !jsonString )
    {
        return @"";
    }
    
    NSError* error = nil;
    id jsonObject = nil;
    @try {
        jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                     options:NSJSONReadingMutableLeaves
                                                       error:&error];
    } @catch (NSException *exception) {
        return nil;
    }
    
    
    if( error )
    {
        NSLog(@"json decode error: %@", error);
        return nil;
    }
    
    return jsonObject;
}

@implementation NSObject (JSON)

-(NSString*) JSONString
{
    return jsonString(self);
}

-(id) objectFromJSONString
{
    if( [self isKindOfClass:[NSString class]] )
    {
        return objectFromJSONString((NSString*)self);
    }
    else
    {
        return self;
    }
}

@end
