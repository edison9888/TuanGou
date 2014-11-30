//
//  MTMapController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-17.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTMapController.h"
#import <MapKit/MapKit.h>
#import "MTDeal.h"
#import "MTDealTool.h"
#import "MTAnnotation.h"
#import "MTBusiness.h"
#import "MTMetaDataTool.h"
#import "MTCover.h"
#import "MTDealDetailController.h"
#import "MTNavigationController.h"
#import "MTCollectTool.h"
#import "UIBarButtonItem+YGCCategory.h"
#define kSpan MKCoordinateSpanMake(0.005101, 0.004092)

@interface MTMapController ()<MKMapViewDelegate>
{
    MKMapView *_mapview;
    
    //已经显示了的团购信息
    NSMutableArray *_showdeals;
    
    MTCover *_cover;//团购详情遮盖层
    
    //团购详情控制器
    MTNavigationController *_detaicontroller;
}
@end

@implementation MTMapController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景颜色
    self.view.backgroundColor=kGlobaBg;
    self.title=@"地图";
    
    //添加地图视图
    MKMapView *mapview=[[MKMapView alloc]initWithFrame:self.view.bounds];
    mapview.autoresizingMask=self.view.autoresizingMask;
    mapview.showsUserLocation=YES;
    mapview.delegate=self;
    [self.view addSubview:mapview];
    
    //初始化在地图上已经显示了的团购信息
    _showdeals=[NSMutableArray array];
    
    //添加回到用户位置按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(loacation) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(self.view.frame.size.width-69, self.view.frame.size.height-69, 59, 59);
    [button setBackgroundImage:[UIImage imageNamed:@"btn_map_locate"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_map_locate_hl"] forState:UIControlStateHighlighted];
    button.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:button];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    //此方法会不停的调用，为了只让地图定位一次，所以用_mapview标记
    if(_mapview==nil)
    {
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.coordinate,kSpan);
            [mapView setRegion:region animated:YES];
        _mapview=mapView;
        [self getDeals];
    }
}

-(void)getDeals
{
    [[MTDealTool sharedMTDealTool] getDealDataWithLocation:_mapview.region.center successBlock:^(id result) {
        if(result)
        {
            if (result[@"deals"]) {
                NSArray *arraydeals=result[@"deals"];
                if(arraydeals.count)
                {
                    for (NSDictionary *dict in arraydeals) {
                        MTDeal *deal=[[MTDeal alloc]initWithDict:dict];
                        //已经显示过大头针的团购不再添加
                        if([_showdeals containsObject:deal]) continue;
                        [_showdeals addObject:deal];
                        if(deal.businesses.count>0)
                        {
                            for (MTBusiness *bus in deal.businesses) {
                                //添加商铺大头针
                                MTAnnotation *antoation=[[MTAnnotation alloc]init];
                                antoation.deal=deal;
                                antoation.business=bus;
                                antoation.coordinate=CLLocationCoordinate2DMake(bus.latitude, bus.longitude);
                                [_mapview addAnnotation:antoation];
                            }
                        }
                    }
                }
            }

        }
    } failureBlock:^(NSError *error) {
        UIAlertView *dialog=[[UIAlertView alloc]initWithTitle:@"错误" message:@"获取周围团购数据失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [dialog show];
    }];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if(_mapview)
    {
        [self getDeals];
    }
}

/**
 显示大头针样式
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MTAnnotation *)annotation
{
    if(![annotation isKindOfClass:[MTAnnotation class]]) return nil;
    
    static NSString *ID=@"Annotation";
    MKAnnotationView *anview=[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (anview==nil) {
        anview=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
    }
    anview.annotation=annotation;
    if(annotation.image)
        anview.image=annotation.image;
    return anview;
}

/**
 大头针点击事件
 */
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if([view.annotation isKindOfClass:[MTAnnotation class]])
    {
        [self showDetail:((MTAnnotation *)view.annotation).deal];
    }
}

//定位我的位置
-(void)loacation
{
    MKCoordinateRegion region=MKCoordinateRegionMake(_mapview.userLocation.coordinate,kSpan);
    [_mapview setRegion:region animated:YES];
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

@end
