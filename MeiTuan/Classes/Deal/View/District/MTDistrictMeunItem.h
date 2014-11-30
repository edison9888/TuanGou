//
//  MTDistrictMeunItem.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDropMenuItem.h"
@class MTDistrict;

@protocol MTDistrictMeunItemDelegate <NSObject>

-(void)MTDistrictItemSelcted:(MTDistrict *)category;

@end

@interface MTDistrictMeunItem : MTDropMenuItem


@property(nonatomic,strong) MTDistrict *district;

@property(nonatomic,weak) id<MTDistrictMeunItemDelegate> delegate;

@end
