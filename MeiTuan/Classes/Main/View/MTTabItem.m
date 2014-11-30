//
//  MTTabItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTTabItem.h"

@implementation MTTabItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

-(void)setEnabled:(BOOL)enabled
{
    //控制顶部分割线要不要显示
    _divder.hidden=!enabled;
    [super setEnabled:enabled];
}

@end
