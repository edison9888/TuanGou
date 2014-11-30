//
//  MTDistrictMeunItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDistrictMeunItem.h"
#import "MTDistrict.h"
@implementation MTDistrictMeunItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//设置区域信息
-(void)setDistrict:(MTDistrict *)district
{
    _district=district;
    [self setTitle:district.name forState:UIControlStateNormal];
}


@end
