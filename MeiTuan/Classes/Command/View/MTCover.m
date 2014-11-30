//
//  MTCover.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-10.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCover.h"

@implementation MTCover

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=kAlpha;
        self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

@end
