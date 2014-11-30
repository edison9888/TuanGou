//
//  MTRestriction.h
//  MeiTuan
//  团购限制条件
//  Created by 叶根长 on 14-10-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRestriction : NSObject

/**
 是否需要预约
 */
@property(nonatomic,assign) BOOL is_reservation_required;

/**
 附件信息
 */
@property(nonatomic,copy) NSString *special_tips;

/**
 是否支持随时退款
 */
@property(nonatomic,assign) BOOL is_refundable;



@end
