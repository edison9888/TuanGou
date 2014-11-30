//
//  MTDealInfoHeaderView.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealInfoHeaderView.h"
#import "UIImage+YGCCategory.h"
#import "MTDeal.h"
#import "UIImageView+WebCache.h"
#import "MTRestriction.h"
@implementation MTDealInfoHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(id)dealInfoHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"MTDealInfoHeaderView" owner:nil options:nil][0];
}



//设置背景图片
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

-(void)setDeal:(MTDeal *)deal
{
    _deal=deal;
    
    //如果接受的带详细信息的团购数据，则给相关控件赋值，不依赖详细数据的控件不重复赋值（比如图片，和剩余时间）
    if (_deal.restriction) {
        //是否支持随时退款
        _anywayback.enabled=_deal.restriction.is_refundable;
        _outdateback.enabled=_deal.restriction.is_refundable;
    }
    else
    {
        //团购图片
        [_dealImg setImageWithURL:[NSURL URLWithString:_deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal.png"]];
        
        //计算剩余时间（当前日期和结束日期对比）
        //获取当前时间
        NSDate *now=[NSDate date];
        
        //格式化截止时间
        NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
        fmt.dateFormat=@"yyyy-MM-dd";
        NSDate *dealline=[fmt dateFromString:_deal.purchase_deadline];
        
        //开始计算剩余时间
        //日历对象，初始化日期格式。格林威治时间格式
        NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        
        //两个日期比较返回的距离类型，这里要计算两个日期相差多少天，多少小时多少分钟
        NSUInteger flags=NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
        
        //调用日期距离计算方法
        NSDateComponents *cmps=[calendar components:flags fromDate:now toDate:dealline options:0];
        
        //拼接显示结果
        NSString *timeStr=[NSString stringWithFormat:@"%d 天 %d 小时 %d 分钟",cmps.day,cmps.hour,cmps.minute];
        
        [_timeRemain setTitle:timeStr forState:UIControlStateNormal];
    }

    //购买人数
    [_purchase_count setTitle:[NSString stringWithFormat:@"%d人购买",_deal.purchase_count] forState:UIControlStateNormal];
    
    //团购描述
    _desclab.text=_deal.desc;
    //计算团购描述文字所占的高度
    CGFloat textheight=[_deal.desc sizeWithFont:_desclab.font constrainedToSize:CGSizeMake(_desclab.frame.size.width, CGFLOAT_MAX) lineBreakMode:_desclab.lineBreakMode].height+10;
    //计算实际文字的高度和lab控件高度之差
    CGRect labf=_desclab.frame;
    CGFloat h=textheight-labf.size.height;
    labf.size.height=textheight;
    _desclab.frame=labf;
        //重新调整整个控件的高度
        CGRect headerF=self.frame;
        headerF.size.height +=h;
        self.frame=headerF;
}

@end
