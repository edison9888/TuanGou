//
//  MTDropDetailMenu.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-22.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDropDetailMenu : UIImageView

/**
 子菜单数组
 */
@property(nonatomic,copy) NSArray *details;

/**
 按钮点击时调用的blcok
 */
@property(nonatomic,copy) void (^btnclickBlock)(NSString *title);

/**
 获取要显示子菜单的文字，
 */
@property(nonatomic,copy) NSString *(^getbtnclickBlock)();

/**
 伴随动画显示
 */
-(void)showWithAnimation;

/**
 伴随动画隐藏
 */
-(void)hideWithAnimation;

@end
