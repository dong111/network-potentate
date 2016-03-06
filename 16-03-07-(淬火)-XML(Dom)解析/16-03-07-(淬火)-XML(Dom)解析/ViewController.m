//
//  ViewController.m
//  16-03-07-(淬火)-XML(Dom)解析
//
//  Created by 陈栋 on 16/3/7.
//  Copyright © 2016年 man. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"


@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *videos;

@end

@implementation ViewController

- (NSArray *)videos
{
    if (_videos==nil) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    //网络获取数据
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/static/xml/videos.xml"];
    
    // 2. 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    
    // 3. 连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //将xml读入内存，生成GDataXMLDocument对象
        //开始遍历element
        
        //开始遍历属性
        
        
    }];


}



@end
