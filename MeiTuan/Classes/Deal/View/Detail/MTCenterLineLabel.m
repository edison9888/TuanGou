//
//  MTCenterLineLabel.m
//  MeiTuan
//  带划线的Label
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCenterLineLabel.h"

@implementation MTCenterLineLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //1 获得上下文
   CGContextRef ctx= UIGraphicsGetCurrentContext();
    //设置颜色
    [self.textColor setStroke];
    
    //画线
    //中点y值
    CGFloat centery=rect.size.height*0.5;
   //设置线条宽度
    CGContextSetLineWidth(ctx, 1);
    //计算文字宽度，文字有多宽，线条就有多宽
    CGFloat endx=[self.text sizeWithFont:self.font].width;
     //设置线条的起点
    CGContextMoveToPoint(ctx, 0, centery);
    CGContextAddLineToPoint(ctx, endx, centery);
    
    //渲染
    CGContextStrokePath(ctx);
}

@end
