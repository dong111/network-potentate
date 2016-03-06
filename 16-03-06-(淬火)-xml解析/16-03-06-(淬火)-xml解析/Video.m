//
//  Video.m
//  16-03-06-(淬火)-xml解析
//
//  Created by 陈栋 on 16/3/6.
//  Copyright © 2016年 man. All rights reserved.
//

#import "Video.h"

@implementation Video

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) videoWithDic:(NSDictionary *)dic{
    return [[Video alloc] initWithDic:dic];
}





@end
