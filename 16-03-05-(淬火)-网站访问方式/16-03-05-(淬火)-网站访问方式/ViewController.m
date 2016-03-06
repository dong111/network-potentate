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




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self demo3];
}

//json数据反序列化
- (void) demo3
{
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/api/v1/ios/list"];
    
    // 2. 建立请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2];
    
    
    // 3. 连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        /**
         容器是可变的，结果是可变的
         *NSJSONReadingMutableContainers = (1UL << 0),
         叶子节点是可变的
         NSJSONReadingMutableLeaves = (1UL << 1),
           允许根节点 可以不是NSArray，
         NSJSONReadingAllowFragments = (1UL << 2)
         */
        
        
       id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        NSLog(@"result :%@ --> %@",result,[result class]);
        
        
    }];
    
}



//同步请求
- (void) demo2
{
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/api/v1/ios/list"];
    
    // 2. 建立请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2];
    
    NSURLResponse *rsp = nil;
    NSError *error =nil;
    // 3. 建立连接Connection， 发送同步请求到服务器
    /**
     参数:
     SynchronousRequest发送同步请求
     returningResponse: 服务器响应的地址
     
     
     error: 错误信息的地址
     
     NULL：本质就是0, 表示的是地址是0 (swift里面取消了NULL)
     nil: 表示地址为0的空对象, 可以给nil发消息
     */
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&rsp error:&error];
    
    NSString *rspStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",rspStr);
    
}



/**
 *  网络连接
 
 NSURLRequestUseProtocolCachePolicy = 0,//默认缓存策略，会自动缓存
 
 NSURLRequestReloadIgnoringLocalCacheData = 1,//忽略本地缓存，重新加载


 下面两种策略 一般是离线时候请求使用。一般配合Reachability(苹果提供的检测网络连接的框架)使用
 
 //用户使用wifi时候使用
 NSURLRequestReturnCacheDataElseLoad = 2,//如果有缓存就使用缓存，没有就上网加载
 
 //下面这种策略实用3G网络
 NSURLRequestReturnCacheDataDontLoad = 3,//如果有缓存就用缓存，没有就返回空，不会上网加载
 
 
 
* timeoutInterval 超时时间设置，默认是60秒，一般设置成15-20秒。超过这个时间就不用等待了
 
 
 
 *NSURLConnection 与服务器建立连接
 
 
 参数:Request 请求
 queue: 队列，这个队列，是完成以后，回调block执行的队列、
 Asynchronous：只要是异步，肯定会开新的线程
 
 // 使用场景：如果下载的是压缩包，解压缩也是耗时操作。也需要放在子线程
 // 如果回调block里面只需要更新UI，那么就可以只开始指定queue为主队列
 response: 服务器的响应（包含响应行/响应头...下载的时候才去关心这个）
 data： 返回的二进制数据
 connectionError：在连接服务器的时候的错误，只要是能正常连接到服务器，就不会有错。
 只要有网络候出现的错访问，就会可能有错误、
 
 
 

 */
- (void) demo1
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/api/v1/ios/list"];
    
//   NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLRequest *request =  [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError || data == nil) {
            NSLog(@"%@----您的网络不给力，请稍后再试", connectionError);
            return;
        }// url错了，才会有错误信息
        

        NSString *rspData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
        NSLog(@"%@",rspData);


    }];
    
}






- (void)viewDidLoad {
    [super viewDidLoad];

//    [self callBaidu];
}

//访问百度

- (void) callBaidu
{
    
    //确定一个url
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //建立一个request
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //添加请求头信息:用户代理 User Agent，是指浏览器,它的信息包括硬件平台、系统软件、应用软件和用户个人偏好。
    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko)"  forHTTPHeaderField:@"user-Agent"];
    
    //和服务器建立连接 并且处理请求数据
    
#pragma --mark这个方法以及过时  寻找更好的解决方案
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        NSString *rspStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //            NSLog(@"%@",rspStr);
        [self.webView loadHTMLString:rspStr baseURL:url];
        
    }];
}



@end
