//
//  Video.h
//  16-03-06-(淬火)-xml解析
//
//  Created by 陈栋 on 16/3/6.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic, copy) NSNumber *videoId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *length;
@property (nonatomic, copy) NSString *videoURL;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *teacher;


- (instancetype) initWithDic:(NSDictionary *)dic;

+ (instancetype) videoWithDic:(NSDictionary *)dic;




@end
