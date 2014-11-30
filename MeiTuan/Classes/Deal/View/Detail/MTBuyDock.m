//
//  MTBuyDock.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTBuyDock.h"
#import "MTDeal.h"
#import "MTCenterLineLabel.h"
#import "UIImage+YGCCategory.h"
@implementation MTBuyDock

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
    _listprict.text=[@(deal.current_price) description];
    _currentprice.text=[NSString stringWithFormat:@"%@元",[@(deal.list_price) description]];
    
}

+(id)buyDock
{
    return [[NSBundle mainBundle]loadNibNamed:@"MTBuyDock" owner:nil options:nil][0];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}

@end
