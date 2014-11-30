//
//  MTInfoTextView.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-22.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTInfoTextView : UIView

/**
 从XIB中创建View
 */
+(id)InfoTextView;

@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

/**
 图标图片名称
 */
@property(nonatomic,copy) NSString *icon;

/**
 标题
 */
@property(nonatomic,copy) NSString *title;

/**
 内容
 */
@property(nonatomic,copy) NSString *content;

@end
