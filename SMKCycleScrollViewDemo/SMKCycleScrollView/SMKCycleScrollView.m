//
//  SMKCycleScrollView.m
//  SMKCycleScrollViewDemo
//
//  Created by Mac on 17/5/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SMKCycleScrollView.h"
#import "UIView+SEKExtension.h"

@interface SMKCycleScrollView ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  滚动视图
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  拼接后的文字数组
 */
@property (nonatomic,strong) NSMutableArray *titleNewArray;

@end

@implementation SMKCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addTimer];
        self.backColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (void)setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
    
    if (titleArray == nil) {
        [self removeTimer];
        return;
    }
    
    if (titleArray.count == 1) {
        [self removeTimer];
    }
    
//    id lastObj = [titleArray lastObject];
//    NSMutableArray *objArray = [[NSMutableArray alloc] init];
//    [objArray addObject:lastObj];
//    [objArray addObjectsFromArray:titleArray];
    self.titleNewArray = [titleArray mutableCopy];//objArray;
    
    [self.tableView reloadData];
    
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    
    _isCanScroll = isCanScroll;
    self.tableView.scrollEnabled = isCanScroll;
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    [self.tableView reloadData];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [self.tableView reloadData];
}

- (void)nextLabel {
    
    CGPoint oldPoint = self.tableView.contentOffset;
    oldPoint.y += 32;
    [self.tableView setContentOffset:oldPoint animated:YES];
    
}

#pragma mark --------------------  UITableView DataSource && Delegate  --------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleNewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CycleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.backgroundColor = self.backColor;
    cell.textLabel.textColor = self.titleColor;
    cell.textLabel.font = self.titleFont;
    cell.textLabel.text = self.titleNewArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.selectedBlock ?: self.selectedBlock(indexPath.row, self.titleNewArray[indexPath.row]);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.y == scrollView.frame.size.height*(self.titleArray.count )) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];

    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开启定时器
    [self addTimer];
}

- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark --------------------  懒加载  --------------------
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 32;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.pagingEnabled = YES;

        [_tableView registerClass:[CycleViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableView];
    }
    
    return _tableView;
}

@end


@implementation CycleViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.x = 0;
    self.textLabel.y = 0;
    self.textLabel.width = self.contentView.width;
    self.textLabel.height = self.contentView.height;
    
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    
}

@end
