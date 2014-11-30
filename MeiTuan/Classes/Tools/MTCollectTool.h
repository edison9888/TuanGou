//
//  MTCollectTool.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-23.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class MTDeal;

@interface MTCollectTool : NSObject

//单例模式
singleton_interface(MTCollectTool)
/**
 获取所有收藏
 */
@property(nonatomic,strong,readonly) NSArray * collectDeals;

/**
 添加收藏
 */
-(void)collectDeal:(MTDeal *)deal;

/**
 取消收藏
 */
-(void)uncollectDeal:(MTDeal *)deal;

/**
 查看一个团购对象是否收藏
 */
-(BOOL)isCollectedDeal:(MTDeal *)deal;

@end
