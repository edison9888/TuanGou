//
//  MTAnnotation.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-25.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class MTDeal;
@class MTBusiness;

@interface MTAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 团购信息
 */
@property(nonatomic,strong) MTDeal *deal;

/**
 商家信息
 */
@property(nonatomic,strong) MTBusiness *business;

/**
 大头针图标
 */
@property(nonatomic,strong) UIImage *image;

@end
