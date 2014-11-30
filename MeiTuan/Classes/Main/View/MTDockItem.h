//
//  MTDockItem.h
//  MeiTuan
//  Dock上所有的Item的父类
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDockItem : UIButton
{
    UIImageView *_divder;//顶部分割线
}
-(void)seticon:(NSString *)icon selectedicon:(NSString *)selectedicon;

@property(nonatomic,copy)NSString *icon; //普通状态下的图片

@property(nonatomic,copy)NSString *selectedicon;//选中状态下的图片



@end
