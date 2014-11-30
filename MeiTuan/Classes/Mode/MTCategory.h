//
//  MTCategory.h
//  MeiTuan
//  团购分类模型
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCategory : NSObject

/**
 分类名称
 */
@property(nonatomic,copy) NSString *name;

/**
 分类图标
 */
@property(nonatomic,copy) NSString *icon;

/**
 分类明细
 */
@property(nonatomic,strong) NSArray *subcategories;
@end
