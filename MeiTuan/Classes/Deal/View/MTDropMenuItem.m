//
//  MTDropMenuItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDropMenuItem.h"
#import "UIImage+YGCCategory.h"
@implementation MTDropMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //文字的位置
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
       
        //文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:13];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //图像内容居中
        self.imageView.contentMode=UIViewContentModeCenter;
        
        //分割线
        UIImage *img=[UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *line=[[UIImageView alloc]init];
        line.image=img;
        line.frame=CGRectMake(kDropMenuWidth, 0, 1, kDropMenuHight);
        [self addSubview:line];
        
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
    }
    return self;
}

//固定宽高
-(void)setFrame:(CGRect)frame
{
    frame.size.width=kDropMenuWidth;
    frame.size.height=kDropMenuHight;
    [super setFrame:frame];
}

//重新设置图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if([self imageForState:UIControlStateNormal])
    {
        CGFloat x=0;
        CGFloat y=2;
        CGFloat w=contentRect.size.width;
        CGFloat h=contentRect.size.height*0.5;
        
        return CGRectMake(x, y, w, h);
    }
    else
        return contentRect;
}

//重新设置文字的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if([self imageForState:UIControlStateNormal])
    {
        CGFloat x=0;
        CGFloat y=contentRect.size.height*0.5-2;
        CGFloat w=contentRect.size.width;
        CGFloat h=contentRect.size.height*0.5;
         return CGRectMake(x, y, w, h);
    }
    else
        return contentRect;
}

@end
