//
//  MTDealCell.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-6.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDeal;
@interface MTDealCell : UICollectionViewCell


/**
 团购信息
 */
@property(nonatomic,strong) MTDeal *deal;

/**
 团购项缩略图
 */
@property (weak, nonatomic) IBOutlet UIImageView *dealImage;

/**
 团购标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title;

/**
 购买数量
 */
@property (weak, nonatomic) IBOutlet UIButton *btnpurchasecount;

/**
 现价
 */
@property (weak, nonatomic) IBOutlet UILabel *labcurrent_price;

/**
 团购标签
 */
@property (weak, nonatomic) IBOutlet UIImageView *badge;

@end
