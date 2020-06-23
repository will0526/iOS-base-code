//
//  JSON.h
//  SUPAY
//
//  Created by will on 15/9/21.
//  Copyright (c)will 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* JSONString(id object);
id objectFromJSONString(NSString* jsonString);


@interface NSObject (JSON)

-(NSString*) JSONString;
-(id) objectFromJSONString;

@end
