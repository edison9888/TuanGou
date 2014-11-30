//
//  MTDistrictMeun.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDistrictMeun.h"
#import "MTDistrict.h"
#import "MTCity.h"
#import "MTMetaDataTool.h"
#import "MTDistrictMeunItem.h"

@interface MTDistrictMeun ()
{
   
}
@end

@implementation MTDistrictMeun

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self setDistricts];
}

//设置区域数据
-(void)setDistricts
{
    [_scrollview.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    MTCity *city=[MTMetaDataTool sharedMTMetaDataTool].currentCity;
    for (int i=0; i<city.districts.count; i++) {
        MTDistrictMeunItem *item=[[MTDistrictMeunItem alloc]init];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.district=city.districts[i];
        item.frame=CGRectMake(i*kDropMenuWidth, 0, kDropMenuWidth, kDropMenuHight);
        [_scrollview addSubview:item];
    }
    _scrollview.contentSize=CGSizeMake(kDropMenuWidth*city.districts.count, 0);
}

-(NSArray *)details:(MTDropMenuItem *)item
{
    MTDistrictMeunItem *disitem=(MTDistrictMeunItem *)item;
    if (!disitem.district.neighborhoods.count) {
        [MTMetaDataTool sharedMTMetaDataTool].currentDistrict=disitem.district.name;
    }
    return disitem.district.neighborhoods;
}

//当前选择城市发生改变
-(void)selectedCityChange
{
    [self setDistricts];
    
    //隐藏子菜单
    [_detailView hideWithAnimation];
}

//子菜单点击时候调用,设置当前全局选择的商区名称
-(void)detailClick:(NSString *)title
{
    [MTMetaDataTool sharedMTMetaDataTool].currentDistrict=title;
    [super detailClick:title];
}

//返回当前全局选择的商区名称
-(NSString *)getDetailTitile
{
    return [MTMetaDataTool sharedMTMetaDataTool].currentDistrict;
}


@end
