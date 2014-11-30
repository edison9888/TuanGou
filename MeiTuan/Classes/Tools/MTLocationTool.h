//
//  MTLocationTool.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-25.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class MTCity;
@interface MTLocationTool : NSObject

singleton_interface(MTLocationTool)

/**
 开始定位
 */
-(void)startLocalation;

/**
 定位城市
 */
@property(nonatomic,strong) MTCity *loclationCity;

@end
