//
//  ViewController.m
//  LoopScrollView
//
//  Created by weikeyan on 2017/10/12.
//  Copyright © 2017年 weikeyan. All rights reserved.
//

#import "ViewController.h"
#import "QCLoopScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    QCLoopScrollView * scrollView = [[QCLoopScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    [self.view addSubview:scrollView];
    scrollView.imageURLArray = @[@"http://cnstatic01.e.vhall.com/upload/webinars/img_url/14/07/1407086d801f383187d87a0b79feac78.png?size=640x360",@"http://cnstatic01.e.vhall.com/upload/webinars/img_url/14/07/1407086d801f383187d87a0b79feac78.png?size=640x360"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
