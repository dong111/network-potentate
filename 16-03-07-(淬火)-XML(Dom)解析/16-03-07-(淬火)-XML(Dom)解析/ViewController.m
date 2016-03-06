//
//  ViewController.m
//  16-03-07-(淬火)-XML(Dom)解析
//
//  Created by 陈栋 on 16/3/7.
//  Copyright © 2016年 man. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"
#import "GDataXMLNode.h"


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
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data encoding:NSUTF8StringEncoding error:NULL];
        
        
        //开始遍历第一级节点element
        for (GDataXMLElement *ele in document.rootElement.children) {
//            NSLog(@"-->%@",ele);
            //构造Video对象
            Video *video = [[Video alloc] init];
            //遍历第二级节点
            for (GDataXMLElement *ele2 in ele.children) {
                //给对象属性赋值
                [video setValue:ele2.stringValue forKeyPath:ele2.name];
            }
            
            //遍历第一级元素属性节点
            for (GDataXMLNode *node in ele.attributes) {
//                NSLog(@"attr -->%@",node);
                [video setValue:node.stringValue forKeyPath:node.name];
                
            }
            //添加到数组
            [self.videos addObject:video];
            
        }
        
        NSLog(@"videos count =%@",self.videos);
        
        
    }];


}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *array = @[@"张三", @"lisi", @"123"];
    
    NSLog(@"%@", array);
    
//        for (NSString *str in array) {
//            NSLog(@"%@", str);
//        }
}








@end
