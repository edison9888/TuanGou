//
//  MTCollectTool.m
//  MeiTuan
//  处理收藏存储业务
//  Created by 叶根长 on 14-10-23.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCollectTool.h"
#import "Singleton.h"
#import "MTDeal.h"
#define kCollectFile @"CollectFile"

@interface MTCollectTool ()
{
    NSMutableArray *_collectDeals;
}
@end

@implementation MTCollectTool

singleton_implementation(MTCollectTool)

-(id)init
{
    if(self=[super init])
    {
        _collectDeals=[NSKeyedUnarchiver unarchiveObjectWithFile:kAppendDocPath(kCollectFile)];
        if (_collectDeals==nil) {
            _collectDeals=[NSMutableArray array];
        }
        
    }
    return self;
}

//收藏
-(void)collectDeal:(MTDeal *)deal
{
    deal.colleced=YES;
    [_collectDeals insertObject:deal atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_collectDeals toFile:kAppendDocPath(kCollectFile)];
    
    [self sendCollectNoti];
}

/**
 取消收藏
 */
-(void)uncollectDeal:(MTDeal *)deal
{
    deal.colleced=NO;
    [_collectDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectDeals toFile:kAppendDocPath(kCollectFile)];
    
    [self sendCollectNoti];
}

//发出收藏数据改变通知
-(void)sendCollectNoti
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNoti object:nil];
}

//查看一个团购是否收藏
-(BOOL)isCollectedDeal:(MTDeal *)deal
{
    //当前收藏列表中是否包含传过来的团购对象
    return [_collectDeals containsObject:deal];
}

@end
