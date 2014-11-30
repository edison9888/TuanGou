//
//  MTDeal.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-29.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTRestriction;
@interface MTDeal : NSObject<NSCoding>

/**
 根据字典初始化团购对象
 @param dict 字典数据
 */
-(MTDeal *)initWithDict:(NSDictionary *)dict;

/**
 团购信息变化
 */
@property(nonatomic,copy) NSString *deal_id;

/**
 团购信息名称
 */
@property(nonatomic,copy) NSString *title;

/**
 团购信息描述
 */
@property(nonatomic,copy) NSString *desc;

/**
 城市
 */
@property(nonatomic,copy) NSString *city;

/**
 原价
 */
@property(nonatomic,assign) float list_price;

/**
 现价
 */
@property(nonatomic,assign) float current_price;

/**
 所属分类
 */
@property(nonatomic,copy) NSArray *categories;

/**
 购买数量
 */
@property(nonatomic,assign) int purchase_count;

/**
 截止日期
 */
@property(nonatomic,copy) NSString *purchase_deadline;

/**
 发布日期
 */
@property(nonatomic,copy) NSString *publish_date;

/**
 团购图片(大图)
 */
@property(nonatomic,copy) NSString *image_url;

/**
 团购图片(小图)
 */
@property(nonatomic,copy) NSString *s_image_url;

/**
 团购链接，适用于网页应用
 */
@property(nonatomic,copy) NSString *deal_url;

/**
 团购Html5链接，适用于移动应用
 */
@property(nonatomic,copy) NSString *deal_h5_url;

/**
 重要通知
 */
@property(nonatomic,copy) NSString *notice;

/**
 团购详情
 */
@property(nonatomic,copy) NSString *details;

/**
 限制条件
 */
@property(nonatomic,strong) MTRestriction *restriction;

/**
 商铺信息
 */
@property(nonatomic,strong) NSArray *businesses;

/**
 是否被收藏
 */
@property(nonatomic,assign) BOOL colleced;



@end
