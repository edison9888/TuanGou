//
//  MTDealInfoHeaderView.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDeal;
@interface MTDealInfoHeaderView : UIView

@property(nonatomic,strong) MTDeal *deal;

/**
 从XIB中创建View
 */
+(id)dealInfoHeaderView;

/**
 团购图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dealImg;

/**
 团购描述
 */
@property (weak, nonatomic) IBOutlet UILabel *desclab;

/**
 支持随时退款
 */
@property (weak, nonatomic) IBOutlet UIButton *anywayback;

/**
 支持过期退款
 */
@property (weak, nonatomic) IBOutlet UIButton *outdateback;

/**
 剩余时间
 */
@property (weak, nonatomic) IBOutlet UIButton *timeRemain;
/**
 购买人数
 */
@property (weak, nonatomic) IBOutlet UIButton *purchase_count;


@end
