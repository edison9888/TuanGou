//
//  MTMetaData.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTMetaDataTool.h"
#import "MTCitySection.h"
#import "NSObject+Value.h"
#import "MTCity.h"
#import "MTCategory.h"
#import "MTShortType.h"
//保存最近访问城市文件路径
#define kreusedCitisePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"reusedCitise.data"]

@interface MTMetaDataTool ()
{
    NSArray *_allCities;
    
    NSMutableArray *_reusedCitise;//最近选择的城市
    
    MTCitySection *_reusedsection;
}
@end

@implementation MTMetaDataTool

singleton_implementation(MTMetaDataTool)

//重写初始化方法,工具类初始化的时候，顺便一起初始化所有元数据
-(id)init
{
    if(self=[super init])
    {
        //加载城市数据
        [self loadcities];
        
        //加载分类数据
        [self loadCategories];
        
        //加载所有排序数据
        [self loadShortType];
    }
    return self;
}

#pragma mark 加载城市数据
//加载所有城市数据
-(void)loadcities
{
    //加载pilst数据
    NSArray *cities=[NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    //临时存放城市数据
    NSMutableArray *citySections=[NSMutableArray array];
    
    
    
    //添加热门城市组
    MTCitySection *hotsection=[[MTCitySection alloc]init];
    hotsection.name=@"热门城市";
    //存放所有热门城市
    NSMutableArray *hotcities=[NSMutableArray array];
    hotsection.cities=hotcities;
    [citySections addObject:hotsection];
    
    
    //循环所有城市分组数据
    NSMutableArray *allcities=[NSMutableArray array];
    for (NSDictionary *dic in cities) {
        MTCitySection *section=[[MTCitySection alloc]init];
        [section setValues:dic];
        [citySections addObject:section];
        
        //循环每个分组下面的城市
        for (MTCity *city in section.cities) {
            if (city.hot) {
                [hotcities addObject:city];
            }
            [allcities addObject:city];
            
        }
    }
    _allCities=[NSArray arrayWithArray:allcities];
    
    //从沙盒中取出最近选择的城市
    NSMutableArray  *reusedCitise=[NSKeyedUnarchiver unarchiveObjectWithFile:kreusedCitisePath];
    
    _reusedCitise=[NSMutableArray array];
    //最近选择城市
    _reusedsection=[[MTCitySection alloc]init];
    _reusedsection.name=@"最近访问";
    for (MTCity *city in reusedCitise) {
        for (MTCity *item in _allCities) {
            if ([city.name isEqualToString:item.name]) {
                [_reusedCitise addObject:item];
            }
        }
    }
    _reusedsection.cities=_reusedCitise;
    if(_reusedCitise.count>0)
    {
        [citySections insertObject:_reusedsection atIndex:0];
    }
    
    
    //把临时变量赋值给属性变量
    _allCitySections=citySections;

}


//设置当前城市
-(void)setCurrentCity:(MTCity *)currentCity
{
    _currentCity=currentCity;
    _currentDistrict=kAllDistrictText;
    if(_reusedCitise==nil)
        _reusedCitise=[NSMutableArray array];
    
    //移除历史选择
    [_reusedCitise removeObject:currentCity];
    
    //插入新的选择到第一个位置
    [_reusedCitise insertObject:currentCity atIndex:0];
    
    //归档
    [NSKeyedArchiver archiveRootObject:_reusedCitise toFile:kreusedCitisePath];
    
    //发出当前选择城市改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNoti object:nil];
    
    //如果没有最近访问组，则插入
    if (![_allCitySections containsObject:_reusedsection]) {
        [(NSMutableArray *)_allCitySections insertObject:_reusedsection atIndex:0];
    }
    
    
}

//设置当前选择分类
-(void)setCurrentCategoryTitle:(NSString *)currentCategoryTitle
{
    _currentCategoryTitle=currentCategoryTitle;
    //发出当前选择分类改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kSubCategoryChangeNoti object:nil];
}

//设置当前选择分区
-(void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict=currentDistrict;
    //发出当前选择分类改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kSubDistrictChangeNoti object:nil];
}

//设置当前排序方式发生改变
-(void)setCurrentShortType:(MTShortType *)currentShortType
{
    _currentShortType=currentShortType;
    //发出当前选择排序方式改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kShortChangeNoti object:nil];
}

#pragma mark 加载分类数据
//加载所有分类数据
-(void)loadCategories
{
    //加载pilst数据
    NSArray *datas=[NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    if(datas.count>0)
    {
        //临时存放所有分类数据
        NSMutableArray *categories=[NSMutableArray array];
        for (NSDictionary *dict in datas) {
            MTCategory *category=[[MTCategory alloc]init];
            [category setValues:dict];
            [categories addObject:category];
        }
        _allCategories=categories;
    }
    
}

//根据分类或者子分类名称查找对于的图标
-(NSString *)iconWithCategory:(NSString *)category
{
    for (MTCategory *cate in _allCategories) {
        //与分类名称一致
        if([category isEqualToString:cate.name])
        {
            return cate.icon;
        }
        //或者包含子分类名称
        else if([cate.subcategories containsObject:category])
        {
            return cate.icon;
        }
    }
    return nil;
}

//加载所有排序方式
-(void)loadShortType
{
    
    NSArray *datas=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShortType.plist" ofType:nil]];
    if (datas.count>0) {
        NSMutableArray *shorttypes=[NSMutableArray array];
        for (int i=0; i<datas.count; i++) {
            MTShortType *shorttype=[[MTShortType alloc]init];
            shorttype.name=datas[i];
            shorttype.index=i+1;
            [shorttypes addObject:shorttype];
            
        }
        _allShortTypes=[NSArray arrayWithArray:shorttypes];
    }
}


@end
