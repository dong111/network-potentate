//
//  ViewController.m
//  16-03-06-(淬火)-xml解析
//
//  Created by 陈栋 on 16/3/6.
//  Copyright © 2016年 man. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"

@interface ViewController () <NSXMLParserDelegate>
/**整个xml的数据容器*/
@property(nonatomic,strong)NSMutableArray *videos;

/**第3步拼接字符串*/
@property(nonatomic,strong)NSMutableString *elementString;

/**当前的模型*/
@property(nonatomic,strong) Video *currentVideo;

/**表格的所有数据*/
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation ViewController
- (void)setDataList:(NSMutableArray *)dataList
{
    _dataList = dataList;
    
    // 只要重新给表格的数据容器赋值，就刷新
    [self.tableView reloadData];
    
    // 隐藏刷新控件
    [self.refreshControl endRefreshing];
}


#pragma =mark 实现NSXMLParserDelegate方法

- (NSMutableArray *)videos
{
    if (_videos == nil) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

- (NSMutableString *)elementString
{
    if (_elementString == nil) {
        _elementString = [NSMutableString string];
    }
    return _elementString;
}

//开始解析文档方法
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"1. 打开文档, 准备开始解析");
    
    // 初始化数组容器, 清空容器，便于多次加载数据
    [self.videos removeAllObjects];
}

//开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
//    NSLog(@"2.开始遍历节点%@-->%@",elementName,attributeDict);
    
    // 如果开始节点的名称 是video，就创建一个对象
    if ([elementName isEqualToString:@"video"]) {
        self.currentVideo = [[Video alloc] init];
        
        // 设置videoID
        self.currentVideo.videoId = attributeDict[@"videoId"];
    }
    
    // 清空字符串的内容，因为马上要进入第3 个方法，要开始拼接当前的节点的内容
    [self.elementString setString:@""];
}


//解析节点文本元素
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"3.获取节点的文本节点:%@",string);

    
    // 开始拼接
    [self.elementString appendString:string];
}

//4.结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    NSLog(@"4.结束节点:%@",elementName);
    if ([elementName isEqualToString:@"video"]) {
        // 如果结束的节点是video， 需要把这个对象添加到数组
        [self.videos addObject:self.currentVideo];
        
    }else if (![elementName isEqualToString:@"videos"]){
        [self.currentVideo setValue:self.elementString forKeyPath:elementName];
    }
}

//5.结束文档
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"5.xml Document遍历结束！");
    // xml真正解析结束, 可以更新UI, 在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataList = self.videos;
    });
}






#pragma --mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.videos.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Video *video = self.dataList[indexPath.row];
    
    cell.textLabel.text = video.name;
    
    return cell;}




#pragma -mark controller需要处理方法

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
//网络加载xml数据
- (IBAction) loadData
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
