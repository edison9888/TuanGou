//
//  MTDealDetailController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-10.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealDetailController.h"
#import "MTDeal.h"
#import "UIBarButtonItem+YGCCategory.h"
#import "MTBuyDock.h"
#import "MTDetailDock.h"
#import "MTDealInfoController.h"
#import "MTDealWebController.h"
#import "MTDealMerchantController.h"
#import "MTCollectTool.h"
@interface MTDealDetailController ()<MTDetailDockDelegare>
{
    MTDetailDock *_detailDock;
    
    //收藏按钮
    UIBarButtonItem *_collectbaritem;
}
@end

@implementation MTDealDetailController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //基本设定
    [self baseSetting];
    
    //添加顶部dock
    [self addTopDock];
    
    //添加右边的选项卡栏
    [self addDetailDock];
    
    //添加子控制器
    [self addAllChildControllers];
}

//基本设置
-(void)baseSetting
{
    self.title=_deal.title;
    self.view.backgroundColor=kGlobaBg;
    
    //收藏按钮图标
    NSString *collectIcon=_deal.colleced?@"ic_collect_suc.png":@"ic_deal_collect";
    //创建收藏按钮
    _collectbaritem=[UIBarButtonItem barbuttonitemWithImage:collectIcon hilighlight:@"ic_deal_collect_pressed.png" action:@selector(collect) target:self];
    self.navigationItem.rightBarButtonItems=@[
    [UIBarButtonItem barbuttonitemWithImage:@"btn_share.png" hilighlight:@"btn_share_pressed.png" action:nil target:self],
    _collectbaritem];
    
    //监听手势拖动
    [self.navigationController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];

}

-(void)drag:(UIPanGestureRecognizer *)pan
{
    CGFloat tx=[pan translationInView:pan.view].x;
    NSLog(@"%@",NSStringFromCGAffineTransform(pan.view.transform));
   pan.view.transform=CGAffineTransformMakeTranslation(tx, 0);
}

//添加顶部dock
-(void)addTopDock
{
    MTBuyDock *dock=[MTBuyDock buyDock];
    dock.deal=_deal;
    [self.view addSubview:dock];
    dock.frame=CGRectMake(0, 0, self.view.frame.size.width, 70);
    
}

//添加右边的选项卡栏
-(void)addDetailDock
{
    MTDetailDock *dock=[MTDetailDock detailDock];
    dock.delegate=self;
    CGSize size=dock.frame.size;
    CGFloat x=self.view.frame.size.width-size.width;
    CGFloat y=(self.view.frame.size.height-size.height-70)/2;
    dock.frame=CGRectMake(x, y, 0, 0);
    [self.view addSubview:dock];
    _detailDock=dock;
   
}

//添加子控制器
-(void)addAllChildControllers
{
    MTDealInfoController *info=[[MTDealInfoController alloc]init];
    info.deal=_deal;
    [self addChildViewController:info];
    //默认显示第一个控制器
    [self detailDock:nil btnClickFrom:0 to:0];
    
    MTDealWebController *web=[[MTDealWebController alloc]init];
    web.deal=_deal;
    [self addChildViewController:web];
    
    MTDealMerchantController *merchant=[[MTDealMerchantController alloc]init];
    merchant.view.backgroundColor=[UIColor blueColor];
    [self addChildViewController:merchant];
    
}

//dock的代理方法
-(void)detailDock:(MTDetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
    UIViewController *old=self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    UIViewController *new=self.childViewControllers[to];
    new.view.autoresizesSubviews=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    CGFloat w=self.view.frame.size.width-_detailDock.frame.size.width;
    CGFloat h=self.view.frame.size.height;
    new.view.frame=CGRectMake(0, 0, w, h);
    [self.view insertSubview:new.view atIndex:0];
}

//收藏
-(void)collect
{
    if(_deal.colleced)
    {
        [((UIButton *)_collectbaritem.customView) setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect"] forState:UIControlStateNormal];
        [[MTCollectTool sharedMTCollectTool] uncollectDeal:_deal];
    }
    else
    {
        [[MTCollectTool sharedMTCollectTool] collectDeal:_deal];
        [((UIButton *)_collectbaritem.customView) setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    }
}



@end
