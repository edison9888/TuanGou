//
//  MTCityListController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCityListController.h"
#import <objc/message.h>
#import "MTCitySection.h"
#import "MTCity.h"
#import "MTDistrict.h"
#import "MTDistrict.h"
#import "MTCity.h"
#import "NSObject+Value.h"
#import "MTMetaDataTool.h"
#import "MTSearchResutController.h"
#define kSearchBarHeight 44
@interface MTCityListController ()<UITableViewDataSource,UISearchBarDelegate,UITableViewDelegate>
{
    UISearchBar *_searchbar;
    UITableView *_tableview;
    UIView *_coverview;//搜索栏蒙版
    NSMutableArray *_citySections;//所有城市数据
    MTSearchResutController *_searchresult;//搜索结果控制器
}
@end

@implementation MTCityListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSearchBar];
    
    [self addTableView];
    
    _citySections=[NSMutableArray array];
    [self loadCities];
}


-(void)loadCities
{
    
   [_citySections addObjectsFromArray:[[MTMetaDataTool sharedMTMetaDataTool] allCitySections]];

}

//添加搜索条
-(void)addSearchBar
{
    _searchbar=[[UISearchBar alloc]init];
    _searchbar.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    _searchbar.frame=CGRectMake(0,0,self.view.frame.size.width, kSearchBarHeight);
    _searchbar.delegate=self;
    _searchbar.placeholder=@"请输入城市或拼音";
    _searchbar.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_searchbar];
}

//添加表格控件
-(void)addTableView
{
    _tableview=[[UITableView alloc]init];
    _tableview.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;;
    _tableview.frame=CGRectMake(0,kSearchBarHeight, self.view.frame.size.width, self.view.frame.size.height-kSearchBarHeight);
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
}

#pragma UISearchBar代理方法
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton=YES;
    if(_coverview==nil)
    {
        _coverview=[[UIView alloc]init];
        _coverview.autoresizingMask=_searchbar.autoresizingMask;
        _coverview.frame=_tableview.frame;
        _coverview.backgroundColor=[UIColor blackColor];
        _coverview.alpha=0.7;
        [_coverview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelEdit)]];
    }
     [self.view addSubview:_coverview];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self cancelEdit];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self cancelEdit];

}

//取消编辑
-(void)cancelEdit
{
    _searchbar.showsCancelButton=NO;
    [_coverview removeFromSuperview];
    [_searchbar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length==0)
    {
        //隐藏搜索控制器
        [_searchresult.view removeFromSuperview];
    }
    else
    {
        //显示搜索控制器
        if (_searchresult==nil) {
            _searchresult=[[MTSearchResutController alloc]init];
            [self addChildViewController:_searchresult];
            _searchresult.view.frame=_coverview.frame;
            _searchresult.view.autoresizingMask=_coverview.autoresizingMask;

        }
        _searchresult.searchText=searchText;
        [self.view addSubview:_searchresult.view];
    }
}

#pragma mark UITableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySections.count;
}

//每组的数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     MTCitySection *citysection=_citySections[section];
    return  citysection.cities.count;
}

//组头显示名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MTCitySection *citysection=_citySections[section];
    return  citysection.name;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [_citySections valueForKeyPath:@"name"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"CELL";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    MTCitySection *citysection=_citySections[indexPath.section];
    MTCity *city=citysection.cities[indexPath.row];
    cell.textLabel.text= city.name;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCitySection *citysection=_citySections[indexPath.section];
    MTCity *city=citysection.cities[indexPath.row];
    //设置当前选择城市
    [MTMetaDataTool sharedMTMetaDataTool].currentCity=city;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
