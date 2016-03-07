//
//  ViewController.m
//  16-03-07-(淬火)-用户登陆
//
//  Created by 陈栋 on 16/3/7.
//  Copyright © 2016年 man. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postLogin];
}


- (void) postLogin
{
    // 1. url
    NSString *urlString = @"http://localhost:8080/ios/api/v1/ios/post";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. 可变的请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    //设置请求为Post请求
    request.HTTPMethod = @"POST";
    
    
    //指定请求数据体body
    NSString *userName = @"张三";
    NSString *pwd = @"123";
    NSString *bodyStr = [NSString stringWithFormat:@"userName=%@sa&pwd=%@",userName,pwd];
    
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    //3.连接
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"result = %@",str);
        
    }];
    
}


//get 登陆
- (void) getLogin
{
    //准备参数和url
    NSString *userName = @"张三";
    NSString *pwd = @"123";
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8080/ios/api/v1/ios/login?userName=%@sa&pwd=%@",userName,pwd];
    //url里面不能包含中文等特殊字符
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2,准备请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    

    //3.连接
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"result = %@",str);
        
    }];
    
}



@end
