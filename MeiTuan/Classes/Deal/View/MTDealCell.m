//
//  MTDealCell.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-6.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealCell.h"
#import "MTDeal.h"
#import "UIImageView+WebCache.h"
@implementation MTDealCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setDeal:(MTDeal *)deal
{
    _deal=deal;
    //缩略图
    [_dealImage setImageWithURL:[NSURL URLWithString:_deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal.png"]];
    _title.text=deal.desc;
    //购买数量
    [_btnpurchasecount setTitle:[NSString stringWithFormat:@"%d",_deal.purchase_count] forState:UIControlStateNormal];
    //价格
    _labcurrent_price.text=[@(_deal.current_price)description];
    
    //标签
    NSDate *now=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.dateFormat=@"yyyy-MM-dd";
    NSString *nowstr=[format stringFromDate:now];
    //发布日期等于今天，今日新单
    if([deal.publish_date isEqualToString:nowstr])
    {
        _badge.hidden=NO;
        _badge.image=[UIImage imageNamed:@"ic_deal_new.png"];
    }
    //截止日期等于今天，即将结束
    else if([_deal.purchase_deadline isEqualToString:nowstr])
    {
        _dealImage.hidden=NO;
        _badge.image=[UIImage imageNamed:@"ic_deal_soonOver.png"];
    }
    //截止日期小于今天，已结束
    else if ([_deal.purchase_deadline compare:nowstr]==NSOrderedAscending)
    {
        _dealImage.hidden=NO;
        _badge.image=[UIImage imageNamed:@"ic_deal_over.png"];
    }
    else
        _badge.hidden=YES;
}

@end
