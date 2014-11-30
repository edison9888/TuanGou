//
//  MTDealListController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-17.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealListController.h"
#import "MTTopMenu.h"
#import "DPAPI.h"
#import "MTMetaDataTool.h"
#import "MTCity.h"
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
@interface MTDealListController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_mtdeals;//所有团购数据
    MJRefreshHeaderView *_refheaderview;//头部刷新控件
    MJRefreshFooterView *_reffootview;//底部刷新控件
    int _pagecount;//当前数据页码
    
}
@end

@implementation MTDealListController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   //设置界面相关
    [self setUIItems];
    
    //初始化数据源
    _mtdeals=[NSMutableArray array];
    
    //集成刷新控件
    [self addRefresh];
    
//    //设置默认城市
//    [MTMetaDataTool sharedMTMetaDataTool].currentCity=[MTMetaDataTool sharedMTMetaDataTool].allCities[0];
}

//添加刷新控件
-(void)addRefresh
{
    MJRefreshHeaderView *header=[[MJRefreshHeaderView alloc]initWithScrollView:self.collectionView];
    _refheaderview=header;
    header.delegate=self;
    _reffootview=[[MJRefreshFooterView alloc]initWithScrollView:self.collectionView];
    _reffootview.delegate=self;
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //如果是拖动头部刷新，则重置页码为第一页,如果是上拉刷新，累加页码
    if([refreshView isKindOfClass:[MJRefreshHeaderView class]])
        _pagecount=1;
    else
        _pagecount++;
    [[MTDealTool sharedMTDealTool] getDealData:_pagecount successBlock:^(id result) {
        if (result[@"deals"]) {
            NSArray *arraydeals=result[@"deals"];
            if(_pagecount==1)
                [_mtdeals removeAllObjects];
            if(arraydeals.count)
            {
                
                for (NSDictionary *dict in arraydeals) {
                    MTDeal *deal=[[MTDeal alloc]initWithDict:dict];
                    if(deal)
                        [_mtdeals addObject:deal];
                }
            }
            [self.collectionView reloadData];
        }
         [refreshView endRefreshing];
    } failureBlock:^(NSError *error) {
        MyLog(@"%@",[error localizedDescription]);
        [refreshView endRefreshing];
    }];
}

-(void)setUIItems
{
    
    
    //监听当前选择城市改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kCityChangeNoti object:nil];
    //监听区域放生改变
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kSubDistrictChangeNoti object:nil];
    //监听分类发生改变
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kSubCategoryChangeNoti object:nil];
    //监听排序放生改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kShortChangeNoti object:nil];
    
       
    //导航栏右边的搜索框
    UISearchBar *searchbar=[[UISearchBar alloc]init];
    searchbar.frame=CGRectMake(0, 0, 210, 35);
    searchbar.placeholder=@"请输入商品，地址等";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchbar];
    
    //导航栏左边的菜单
    MTTopMenu *topmenu=[[MTTopMenu alloc]init];
    topmenu.dropMenuView=self.view;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:topmenu];
    
//    //注册collectionview的行视图
//    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:@"DealCell"];
//    
//    //设置背景颜色
//    self.collectionView.backgroundColor=nil;
//    self.collectionView.backgroundView.backgroundColor=kGlobaBg;
//    
//    //设置collectionview永远有弹簧效果,就算内容没有超出屏幕高度也可以拖动
//    self.collectionView.alwaysBounceVertical=YES;
    
}

////屏幕旋转后调用发方法
//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [self setItemMargin];
//}

////根据当前屏幕方向调整项之间的间距
//-(void)setItemMargin
//{
//    UICollectionViewFlowLayout *flowlayout= (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    CGFloat v=20;//(垂直)靠上和靠下间距20;
//    CGFloat h=0;//水平方向的间距
//    
//    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
//        //横屏显示3列
//        h=(self.view.frame.size.width-3*kDealItemWidth)/4;
//    }
//    else
//        //竖屏显示2列
//        h=(self.view.frame.size.width-2*kDealItemWidth)/3;
//    
//    flowlayout.sectionInset=UIEdgeInsetsMake(v, h, v, h);
//}

//商区，分类，排序发生改变
-(void)dataChange
{
    _pagecount=1;
    [_refheaderview beginRefreshing];
}


//#pragma mark UICollectionView代理方法
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
//{
//    return _mtdeals.count;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID=@"DealCell";
//    MTDealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    if(cell==nil)
//    {
//        cell=[[MTDealCell alloc]init];
//        cell.restorationIdentifier=ID;
//    }
//    MTDeal *deal=_mtdeals[indexPath.row];
//    cell.deal=deal;
//    return cell;
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MTDeal *deal=_mtdeals[indexPath.row];
//    [self showDetail:deal];
//    
//}

//#pragma mark 显示团购详情
//-(void)showDetail:(MTDeal *)deal
//{
//    if(_cover==nil)
//    {
//        _cover=[[MTCover alloc]init];
//        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetailView)]];
//    }
//    _cover.frame=self.navigationController.view.bounds;
//    _cover.alpha=0;
//    [self.navigationController.view addSubview:_cover];
//    //动画淡入淡出
//    [UIView animateWithDuration:kAnimationTime animations:^{
//        _cover.alpha=kAlpha;
//    }];
//    
//    //显示团购详情控制器
//    //创建控制器
//    MTDealDetailController *detail=[[MTDealDetailController alloc]init];
//    deal.colleced=[[MTCollectTool sharedMTCollectTool] isCollectedDeal:deal];
//    //设置团购模型
//    detail.deal=deal;
//    
//    //当前导航控制器的frame
//    CGRect parentframe=self.navigationController.view.frame;
//    
//    //创建导航控制器
//    MTNavigationController *nav=[[MTNavigationController alloc]initWithRootViewController:detail];
//    _detaicontroller=nav;
//    //设置团购详情的关闭按钮
//    detail.navigationItem.leftBarButtonItem=[UIBarButtonItem barbuttonitemWithImage:@"btn_nav_close.png" hilighlight:@"btn_nav_close_hl.png" action:@selector(hideDetailView) target:self];
//    
//    //设置团购详情导航控制器的自动伸缩属性，只伸缩高度，所有控制器默认会自动伸缩宽高，所以这里要重写
//    nav.view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin;
//    detail.view.autoresizingMask=nav.view.autoresizingMask;
//    //设置团购详情控制的位置默认在最右边看不见的位置，通过动画从右到左显示
//    nav.view.frame=CGRectMake(parentframe.size.width, 0, 600, parentframe.size.height);
//   
//    //当一个控制器的view添加到一个控制器，该控制器的也要成为子控制器
//    [self.navigationController.view addSubview:nav.view];
//    [self.navigationController addChildViewController:nav];
//    
//    //显示动画
//    [UIView animateWithDuration:kAnimationTime animations:^{
//        CGRect frame=nav.view.frame;
//        frame.origin.x -=frame.size.width;
//        nav.view.frame=frame;
//    }];
//}
//
////隐藏团购详情
//-(void)hideDetailView
//{
//    //动画淡入淡出
//    [UIView animateWithDuration:kAnimationTime animations:^{
//        _cover.alpha=0;
//        CGRect frame=_detaicontroller.view.frame;
//        frame.origin.x =self.navigationController.view.frame.size.width;
//        _detaicontroller.view.frame=frame;
//
//    } completion:^(BOOL finished) {
//        [_cover removeFromSuperview];
//        [_detaicontroller.view removeFromSuperview];
//        [_detaicontroller removeFromParentViewController];
//    }];
//}

-(NSArray *)totalDeals
{
    return  _mtdeals;
}

//当前对象销毁前，移除所有监听者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
