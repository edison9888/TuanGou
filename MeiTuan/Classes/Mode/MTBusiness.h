//
//  MTBusiness.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-25.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTBusiness : NSObject

-(MTBusiness *)initWithDict:(NSDictionary *)dict;

/**
 城市
 */
@property(nonatomic,copy) NSString *city;

/**
 编号
 */
@property(nonatomic,assign)  unsigned long int businessID;

/**
 商铺链接
 */
@property(nonatomic,copy) NSString *h5_url;

/**
 维度
 */
@property(nonatomic,assign) float latitude;

/**
 经度
 */
@property(nonatomic,assign) float longitude;

/**
 店铺名称
 */
@property(nonatomic,copy) NSString *name;


@end
