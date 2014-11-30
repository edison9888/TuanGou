//
//  MTShortMenuItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTShortMenuItem.h"
#import "MTShortType.h"
@implementation MTShortMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setShorttype:(MTShortType *)shorttype
{
    _shorttype=shorttype;
    [self setTitle:shorttype.name forState:UIControlStateNormal];
}

@end
