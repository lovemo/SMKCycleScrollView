//
//  SMKCycleScrollView.h
//  SMKCycleScrollViewDemo
//
//  Created by Mac on 17/5/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMKCycleScrollView : UIView

/**
 *  文字数组
 */
@property (nonatomic,strong) NSArray *titleArray;
/**
 *  是否可以拖拽
 */
@property (nonatomic,assign) BOOL isCanScroll;
/**
 *  字体颜色
 */
@property (nonatomic,strong) UIColor *titleColor;
/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *backColor;
/**
 *  字体
 */
@property (nonatomic,strong) UIFont *titleFont;

/**
 *  block回调
 */
@property (nonatomic,copy) void(^selectedBlock)(NSInteger index,NSString *title);

/**
 *  关闭定时器
 */
- (void)removeTimer;

/**
 *  添加定时器
 */
- (void)addTimer;

@end


@interface CycleViewCell : UITableViewCell

@end

