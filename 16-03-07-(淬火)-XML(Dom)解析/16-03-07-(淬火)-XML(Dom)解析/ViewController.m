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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
