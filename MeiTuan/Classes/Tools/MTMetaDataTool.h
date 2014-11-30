//
//  MTMetaData.h
//  MeiTuan
//  元数据管理类
//  1:城市数据
//  2:下属分区类
//  3:分类数据
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class MTCity;
@class MTShortType;
@interface MTMetaDataTool : NSObject

//单例
singleton_interface(MTMetaDataTool)

/**
 所有城市分组数据
 */
@property(nonatomic,strong,readonly) NSArray *allCitySections;

/**
 所有城市数据
 */
@property(nonatomic,strong,readonly) NSArray *allCities;

/**
 当前选择的城市
 */
@property(nonatomic,strong) MTCity *currentCity;

/**
 所有分类数据
 */
@property(nonatomic,strong) NSArray *allCategories;

/**
 根据分类名称获取图片名称
 */
-(NSString *)iconWithCategory:(NSString *)category;

/**
 所有排序类型
 */
@property(nonatomic,strong) NSArray *allShortTypes;

/**
 当前选择的类别子菜单
 */
@property(nonatomic,copy) NSString *currentCategoryTitle;

/**
 当前选择的商区
 */
@property(nonatomic,copy) NSString *currentDistrict;

/**
 当前排序方式
 */
@property(nonatomic,assign) MTShortType *currentShortType;

@end
