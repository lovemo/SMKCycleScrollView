//
//  ViewController.m
//  SMKCycleScrollViewDemo
//
//  Created by Mac on 17/5/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "SMKCycleScrollView.h"

@interface ViewController ()
@property (nonatomic, strong) SMKCycleScrollView *cycleScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cycleScrollView = [[SMKCycleScrollView alloc] init];
    self.cycleScrollView.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 32);
//    self.cycleScrollView.backColor = [UIColor orangeColor];
    self.cycleScrollView.titleColor = [UIColor blackColor];
    self.cycleScrollView.titleFont = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:self.cycleScrollView];
    
    self.cycleScrollView.titleArray = [NSArray arrayWithObjects:
                                       @"微软CEO：我们没有放弃智能手机 会来点不一样的",
                                       @"李彦宏发内部信，再次强调人工智能战略",
                                       @"iPhone 8会亮相6月WWDC吗？分析师为此互相打脸",
                                       @"孙宏斌：乐视汽车贾跃亭该怎么弄怎么弄，其他的该卖的卖掉",
                                       nil];
    
    [self.cycleScrollView setSelectedBlock:^(NSInteger index, NSString *title) {
        NSLog(@"%zd-----%@",index,title);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
