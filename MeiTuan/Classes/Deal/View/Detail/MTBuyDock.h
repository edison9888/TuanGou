//
//  MTBuyDock.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDeal;
@class MTCenterLineLabel;
@interface MTBuyDock : UIView

@property(nonatomic,strong) MTDeal *deal;

@property (weak, nonatomic) IBOutlet UILabel *listprict;
@property (weak, nonatomic) IBOutlet MTCenterLineLabel *currentprice;


+(id)buyDock;

@end
