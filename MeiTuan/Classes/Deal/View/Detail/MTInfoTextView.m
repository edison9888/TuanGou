//
//  MTInfoTextView.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-22.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTInfoTextView.h"
#import "UIImage+YGCCategory.h"
@implementation MTInfoTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//创建视图实例
+(id)InfoTextView
{
    return [[NSBundle mainBundle] loadNibNamed:@"MTInfoTextView" owner:nil options:nil][0];
}

//设置背景图片
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

-(void)setIcon:(NSString *)icon
{
    _icon=icon;
    
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    
    [_titleView setTitle:title forState:UIControlStateNormal];
}

-(void)setContent:(NSString *)content
{
    _content=content;
    
    _contentView.text=content;
    //计算文字高度
    CGFloat textH=[content sizeWithFont:_contentView.font constrainedToSize:CGSizeMake(_contentView.frame.size.width,MAXFLOAT) lineBreakMode:_contentView.lineBreakMode].height;
    CGRect contentF=_contentView.frame;
    //高度之差
    CGFloat h=textH-contentF.size.height;
    
    contentF.size.height=textH;
    _contentView.frame=contentF;
    
    //调整整个控件高度
    CGRect SelfFram=self.frame;
    SelfFram.size.height+=h;
    self.frame=SelfFram;
}

@end
