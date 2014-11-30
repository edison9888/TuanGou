//
//  MTDropMenu.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDropDetailMenu.h"
@class MTDropDetailMenu;
@class MTDropMenuItem;
@interface MTDropMenu : UIView
{
    UIScrollView *_scrollview;
    MTDropDetailMenu *_detailView;
}

/**
 子菜单的数据源
 */
-(NSArray *)details:(MTDropMenuItem *)item;

/**
 下拉标题点击事件
 */
-(void)itemClick:(MTDropMenuItem *)item;

/**
 菜单隐藏时调用的block
 */
@property(nonatomic,copy) void (^hideblock)();

/**
 接受当前选择城市发生变化的通知
 */
-(void)selectedCityChange;

/**
 伴随动画显示
 */
-(void)showWithAnimation;

/**
 伴随动画隐藏
 */
-(void)hideWithAnimation;

/**
 子菜单点击的时候调用方法，让子类实现
 */
-(void)detailClick:(NSString *)title;

/**
 获取当前选择的子菜单的文字
 */
-(NSString *)getDetailTitile;


@end
