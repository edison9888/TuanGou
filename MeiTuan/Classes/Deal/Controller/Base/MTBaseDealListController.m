//
//  MTBaseDealListController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-23.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTBaseDealListController.h"
#import "MTDeal.h"
#import "MTDealCell.h"
#import "UIImageView+WebCache.h"
#import "MTShortType.h"
#import "MJRefresh.h"
#import "MTDealTool.h"
#import "MTCover.h"
#import "MTDealDetailController.h"
#import "UIBarButtonItem+YGCCategory.h"
#import "MTNavigationController.h"
#import "MTCollectTool.h"
#import "MTMetaDataTool.h"

@interface MTBaseDealListController ()
{
    
    MTCover *_cover;//团购详情遮盖层
    
    //团购详情控制器
    MTNavigationController *_detaicontroller;
}
@end

@implementation MTBaseDealListController

-(id)init
{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize=CGSizeMake(250, 250);
    return [super initWithCollectionViewLayout:flowlayout];
}

//将要显示视图
-(void)viewWillAppear:(BOOL)animated
{
    [self setItemMargin];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置界面相关
    [self setUI];
    
}



-(void)setUI
{

    //设置自动伸缩
    self.view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    
    //注册collectionview的行视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:@"DealCell"];
    
    //设置背景颜色
    self.collectionView.backgroundColor=nil;
    self.collectionView.backgroundView.backgroundColor=kGlobaBg;
    
    //设置collectionview永远有弹簧效果,就算内容没有超出屏幕高度也可以拖动
    self.collectionView.alwaysBounceVertical=YES;

}

//屏幕旋转后调用发方法
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setItemMargin];
}


//根据当前屏幕方向调整项之间的间距
-(void)setItemMargin
{
    UICollectionViewFlowLayout *flowlayout= (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat v=20;//(垂直)靠上和靠下间距20;
    CGFloat h=0;//水平方向的间距
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        //横屏显示3列
        h=(self.view.frame.size.width-3*kDealItemWidth)/4;
    }
    else
        //竖屏显示2列
        h=(self.view.frame.size.width-2*kDealItemWidth)/3;
    
    flowlayout.sectionInset=UIEdgeInsetsMake(v, h, v, h);
}

#pragma mark UICollectionView代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return [self totalDeals].count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"DealCell";
    MTDealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[MTDealCell alloc]init];
        cell.restorationIdentifier=ID;
    }
    MTDeal *deal=[self totalDeals][indexPath.row];
    cell.deal=deal;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTDeal *deal=[self totalDeals][indexPath.row];
    [self showDetail:deal];
    
}

#pragma mark 显示团购详情
-(void)showDetail:(MTDeal *)deal
{
    if(_cover==nil)
    {
        _cover=[[MTCover alloc]init];
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetailView)]];
    }
    _cover.frame=self.navigationController.view.bounds;
    _cover.alpha=0;
    [self.navigationController.view addSubview:_cover];
    //动画淡入淡出
    [UIView animateWithDuration:kAnimationTime animations:^{
        _cover.alpha=kAlpha;
    }];
    
    //显示团购详情控制器
    //创建控制器
    MTDealDetailController *detail=[[MTDealDetailController alloc]init];
    deal.colleced=[[MTCollectTool sharedMTCollectTool] isCollectedDeal:deal];
    //设置团购模型
    detail.deal=deal;
    
    //当前导航控制器的frame
    CGRect parentframe=self.navigationController.view.frame;
    
    //创建导航控制器
    MTNavigationController *nav=[[MTNavigationController alloc]initWithRootViewController:detail];
    _detaicontroller=nav;
    //设置团购详情的关闭按钮
    detail.navigationItem.leftBarButtonItem=[UIBarButtonItem barbuttonitemWithImage:@"btn_nav_close.png" hilighlight:@"btn_nav_close_hl.png" action:@selector(hideDetailView) target:self];
    
    //设置团购详情导航控制器的自动伸缩属性，只伸缩高度，所有控制器默认会自动伸缩宽高，所以这里要重写
    nav.view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin;
    detail.view.autoresizingMask=nav.view.autoresizingMask;
    //设置团购详情控制的位置默认在最右边看不见的位置，通过动画从右到左显示
    nav.view.frame=CGRectMake(parentframe.size.width, 0, 600, parentframe.size.height);
    
    //当一个控制器的view添加到一个控制器，该控制器的也要成为子控制器
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    //显示动画
    [UIView animateWithDuration:kAnimationTime animations:^{
        CGRect frame=nav.view.frame;
        frame.origin.x -=frame.size.width;
        nav.view.frame=frame;
    }];
}

//隐藏团购详情
-(void)hideDetailView
{
    //动画淡入淡出
    [UIView animateWithDuration:kAnimationTime animations:^{
        _cover.alpha=0;
        CGRect frame=_detaicontroller.view.frame;
        frame.origin.x =self.navigationController.view.frame.size.width;
        _detaicontroller.view.frame=frame;
        
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_detaicontroller.view removeFromSuperview];
        [_detaicontroller removeFromParentViewController];
    }];
}

//子类实现
-(NSArray *)totalDeals
{
    return nil;
}

@end
