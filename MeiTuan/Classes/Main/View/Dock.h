//
//  Dock.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dock;
@class MTDockItem;

/**
 dock的代理
 */
@protocol MTDockDelegate <NSObject>

-(void)dock:(Dock *)dock tabChangeFrom:(int)from to:(int)to;

///**
// 定位按钮点击触发的事件
// @param dock dock栏
// @param item 定位按钮
// */
//-(void)dock:(Dock *)dock locationClick:(MTDockItem *)item;

@end

@interface Dock : UIView

@property(nonatomic,weak) id<MTDockDelegate> delegate;


@end
