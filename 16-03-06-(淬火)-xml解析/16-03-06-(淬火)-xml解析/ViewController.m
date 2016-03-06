//
//  ViewController.m
//  16-03-06-(淬火)-xml解析
//
//  Created by 陈栋 on 16/3/6.
//  Copyright © 2016年 man. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSXMLParserDelegate>

@end

@implementation ViewController


#pragma =mark 实现NSXMLParserDelegate方法
//开始解析文档方法
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
 NSLog(@"1. 打开文档, 准备开始解析");
}

//开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"2.开始遍历节点%@-->%@",elementName,attributeDict);
}


//解析节点文本元素
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"3.获取节点的文本节点:%@",string);
}

//4.结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"4.结束节点:%@",elementName);
}

//5.结束文档
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"5.xml Document遍历结束！");
}






#pragma --mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}




#pragma -mark controller需要处理方法

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
//网络加载xml数据
- (void) loadData
{
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/ios/static/xml/videos.xml"];
    
    // 2. 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    
    // 3. 连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // xml的解析
        // 1. 实例化一个xml的解析器--通过代理来实现xml的解析
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        
        // 2. 设置代理
        parser.delegate = self;
        
        // 3. 解析器开始解析
        [parser parse];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
