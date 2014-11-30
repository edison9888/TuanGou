//
//  MTCity.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTCityBase.h"
@interface MTCity :MTCityBase<NSCoding>

@property(nonatomic,strong) NSArray *districts;//所有分区

@property(nonatomic,assign) BOOL *hot;//是否热门城市
@end
