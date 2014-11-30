//
//  MTDistrcts.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCityBase.h"

@interface MTDistrict : MTCityBase<NSCoding>

@property(nonatomic,strong) NSArray *neighborhoods;//街道

@end
