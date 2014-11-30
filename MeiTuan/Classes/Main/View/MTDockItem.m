//
//  MTDockItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDockItem.h"

@implementation MTDockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *divder=[[UIImageView alloc]init];
        divder.frame=CGRectMake(0, 0, kDockItemWidth, 2);
        divder.image=[UIImage imageNamed:@"separator_tabbar_item.png"];
        [self addSubview:divder];
        _divder=divder;
    }
    return self;
}


#pragma mark 初始化方法
-(void)setFrame:(CGRect)frame
{
    frame.size.width=kDockItemWidth;
    frame.size.height=kDockItemHeight;
    [super setFrame:frame];
}

#pragma mark 设置按钮内部图片
-(void)seticon:(NSString *)icon selectedicon:(NSString *)selectedicon
{
    [self setIcon:icon];
    [self setSelectedicon:selectedicon];
}

-(void)setIcon:(NSString *)icon
{
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

-(void)setSelectedicon:(NSString *)selectedicon
{
    [self setImage:[UIImage imageNamed:selectedicon] forState:UIControlStateDisabled];
}

#pragma mark 取消高亮状态
-(void)setHighlighted:(BOOL)highlighted{}

@end
