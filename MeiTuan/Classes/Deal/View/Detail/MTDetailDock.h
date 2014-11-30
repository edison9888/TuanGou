//
//  MTDetailDock.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTDetailDock;

//选项卡按钮
@interface MTDetailDockItem : UIButton

@end

//代理协议
@protocol MTDetailDockDelegare <NSObject>

@optional
/**
 选项卡点击后触发的事件
 */
-(void)detailDock:(MTDetailDock *)detailDock btnClickFrom:(int)from to:(int)to;

@end


@interface MTDetailDock : UIView
- (IBAction)btnclick:(UIButton *)sender;

/**
 团购简介
 */
@property (weak, nonatomic) IBOutlet UIButton *btninfo;

//商家详情
@property (weak, nonatomic) IBOutlet MTDetailDockItem *btnmerchan;

/**
 选项卡代理
 */
@property(nonatomic,weak) id<MTDetailDockDelegare> delegate;

//从XIB中获取视图
+(id)detailDock;

@end


