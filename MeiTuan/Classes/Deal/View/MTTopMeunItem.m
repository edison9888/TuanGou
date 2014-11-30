//
//  MTTopMeunItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTTopMeunItem.h"
#import "UIImage+YGCCategory.h"
#define kTitleScale 0.7 //文字的缩放大小
@implementation MTTopMeunItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        //设置箭头
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode=UIViewContentModeCenter;
        
        //右边的分割线
        UIImage *img=[UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *line=[[UIImageView alloc]init];
        line.image=img;
        line.bounds=CGRectMake(0, 0, img.size.width,20);
        line.center=CGPointMake(kTopMenuItemWidth, kTopMenuItemHeight/2);
        [self addSubview:line];
        
        //选中时的背景图片
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    
    [self setTitle:_title forState:UIControlStateNormal];
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x=contentRect.size.width*kTitleScale;
    CGFloat h=contentRect.size.height;
    return CGRectMake(x, 0, 20, h);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h=contentRect.size.height;
    CGFloat w=contentRect.size.width*kTitleScale;
    return CGRectMake(0, 0, w, h);
}

//固定按钮宽高
-(void)setFrame:(CGRect)frame
{
    frame.size.width=kTopMenuItemWidth;
    frame.size.height=kTopMenuItemHeight;
    
    [super setFrame:frame];
}

@end
