//
//  MTCategoryItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCategoryItem.h"
#import "MTCategory.h"
@implementation MTCategoryItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setCategory:(MTCategory *)category
{
    _category=category;
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    [self setTitle:category.name forState:UIControlStateNormal];
}


@end
