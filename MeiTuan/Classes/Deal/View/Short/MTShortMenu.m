//
//  MTShortMenu.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTShortMenu.h"
#import "MTMetaDataTool.h"
#import "MTShortType.h"
#import "MTShortMenuItem.h"
@implementation MTShortMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    NSArray *shorttypes=[MTMetaDataTool sharedMTMetaDataTool].allShortTypes;
    
    for (int i=0; i<shorttypes.count; i++) {
        MTShortMenuItem *item=[[MTShortMenuItem alloc]init];
        item.shorttype=shorttypes[i];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.frame=CGRectMake(i*kDropMenuWidth, 0, kDropMenuWidth, kDropMenuHight);
        [_scrollview addSubview:item];
    }
    _scrollview.contentSize=CGSizeMake(kDropMenuWidth*shorttypes.count, 0);
}

-(void)itemClick:(MTDropMenuItem *)item
{
    [MTMetaDataTool sharedMTMetaDataTool].currentShortType=((MTShortMenuItem *)item).shorttype;
    [super itemClick:item];
}

@end
