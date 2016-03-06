//
//  NSArray+Log.m
//  16-03-07-(淬火)-XML(Dom)解析
//
//  Created by 陈栋 on 16/3/7.
//  Copyright © 2016年 man. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

//array打印本地化方法
- (NSString *)descriptionWithLocale:(id)locale
{
    /**
     (
     "\U5f20\U4e09",
     lisi,
     123
     )
     //格式化本地化输出array
     */
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }];
    
    [strM appendString:@")\n"];
    
    return strM;
}

@end
