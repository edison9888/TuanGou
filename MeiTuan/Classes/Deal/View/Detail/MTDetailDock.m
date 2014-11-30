//
//  MTDetailDock.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDetailDock.h"

@interface MTDetailDock ()
{
    UIButton *_selectItem;
}
@end

@implementation MTDetailDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setFrame:(CGRect)frame
{
    frame.size=self.frame.size;
    [super setFrame:frame];
}

//创建视图
+(id)detailDock
{
    return [[NSBundle mainBundle]loadNibNamed:@"MTDetailDock" owner:nil options:nil][0];

}

//初始化视图的时候，默认点击第一个(团购简洁)
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self btnclick:_btninfo];
}

- (IBAction)btnclick:(UIButton *)sender
{
    //通知代理
    if([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)])
    {
        //调用代理方法
        [_delegate detailDock:self btnClickFrom:_selectItem.tag to:sender.tag];
    }
    
    //控制按钮状态
    _selectItem.enabled=YES;
    sender.enabled=NO;
    _selectItem=sender;
    
    //调整按钮层次显示
    //点击了最上面的按钮，把第三个按钮放到最下面
    if(sender==_btninfo)
    {
        [self insertSubview:_btnmerchan atIndex:0];
    }
    //点击了最下面的按钮，把第一个按钮放到最下面
    else if(sender==_btnmerchan)
    {
        [self insertSubview:_btninfo atIndex:0];
    }
     //添加被点击的按钮在最上边
    [self bringSubviewToFront:sender];
    
    
}

@end

@implementation MTDetailDockItem

-(void)setHighlighted:(BOOL)highlighted{};

@end
