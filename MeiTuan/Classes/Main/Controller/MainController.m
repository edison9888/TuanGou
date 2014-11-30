//
//  MainController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-15.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "MTDealListController.h"
#import "MTMapController.h"
#import "MTMineController.h"
#import "MTCollectController.h"
#import "MTNavigationController.h"
#import "MTMoreController.h"
#import "MTCityListController.h"
#import "MTDockItem.h"
#import "MTMetaDataTool.h"
@interface MainController ()<MTDockDelegate>
{
    UIView *_contentview;
    UIPopoverController *_popover;
}
@end

@implementation MainController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    self.view.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
    Dock *dock=[[Dock alloc]init];
    dock.frame=CGRectMake(0, 0, 0, self.view.frame.size.height);
    [self.view addSubview:dock];
    dock.delegate=self;
    
    //添加内容View，用于伸缩子控制器
    _contentview=[[UIView alloc]init];
    _contentview.backgroundColor=[UIColor clearColor];
    CGFloat w=self.view.frame.size.width-kDockItemWidth;
    CGFloat h=self.view.frame.size.height;
    _contentview.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _contentview.frame=CGRectMake(kDockItemWidth, 0,w,h);
    [self.view addSubview:_contentview];
    
    //添加子控制器
    [self addAllChildControllers];
    
}



-(void)addAllChildControllers
{
    MTDealListController *deal=[[MTDealListController alloc]init];
    MTNavigationController *nav1=[[MTNavigationController alloc]initWithRootViewController:deal];
    [self addChildViewController:nav1];
    
    //地图
    MTMapController *map=[[MTMapController alloc]init];
    MTNavigationController *nav2=[[MTNavigationController alloc]initWithRootViewController:map];
    [self addChildViewController:nav2];
    
    //收藏
    MTCollectController *collect=[[MTCollectController alloc]init];
    MTNavigationController *nav3=[[MTNavigationController alloc]initWithRootViewController:collect];
    [self addChildViewController:nav3];
    
    //我
    MTMineController *mine=[[MTMineController alloc]init];
    MTNavigationController *nav4=[[MTNavigationController alloc]initWithRootViewController:mine];
    [self addChildViewController:nav4];
    
    //默认选中第一项 团购
    [self dock:nil tabChangeFrom:0 to:0];
}


#pragma mark DockItem点击事件
-(void)dock:(Dock *)dock tabChangeFrom:(int)from to:(int)to
{
    //移除旧控制器的view
    UIViewController *old=self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    //添加新控制器的view
    UIViewController *new=self.childViewControllers[to];
    new.view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    //控制器view填充整个contentview的宽高
    new.view.frame=_contentview.bounds;
    [_contentview addSubview:new.view];
}

@end
