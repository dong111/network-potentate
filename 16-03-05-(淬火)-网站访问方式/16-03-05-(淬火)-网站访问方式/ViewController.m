//
//  ViewController.m
//  16-03-05-(淬火)-网站访问方式
//
//  Created by 陈栋 on 16/3/5.
//  Copyright © 2016年 man. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //确定一个url
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //建立一个request
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //添加请求头信息:用户代理 User Agent，是指浏览器,它的信息包括硬件平台、系统软件、应用软件和用户个人偏好。
    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko)"  forHTTPHeaderField:@"user-Agent"];
    
    //和服务器建立连接 并且处理请求数据
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
            NSString *rspStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
//            NSLog(@"%@",rspStr);
        [self.webView loadHTMLString:rspStr baseURL:url];
        
    }];
    
    

    
    

}


@end
