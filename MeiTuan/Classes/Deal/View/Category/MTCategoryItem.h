//
//  MTCategoryItem.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDropMenuItem.h"
@class MTCategory;
@class MTCategoryDetailMenu;


@interface MTCategoryItem : MTDropMenuItem

@property(nonatomic,strong) MTCategory *category;

@end
