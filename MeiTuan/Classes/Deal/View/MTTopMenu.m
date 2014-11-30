//
//  MTTopMenu.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTTopMenu.h"
#import "MTTopMeunItem.h"
#import "MTCategory.h"
#import "MTMetaDataTool.h"
#import "MTCategoryMenu.h"
#import "MTDistrictMeun.h"
#import "MTShortMenu.h"
#import "MTMetaDataTool.h"
#import "MTShortType.h"
@interface MTTopMenu ()
{
    MTTopMeunItem *_selectedItem;//当前选中的菜单
    
    MTCategoryMenu *_catemenu;//分类下拉菜单View
    MTDistrictMeun *_dismenu;//商区下拉菜单View
    MTShortMenu *_shortMenu;//默认排序菜单View
    
    MTTopMeunItem *_cateitem;//全部分类菜单按钮
    MTTopMeunItem *_distitem;//全部商区菜单按钮
    MTTopMeunItem *_shortitem;//排序菜单按钮
    
    MTDropMenu *_showdropmenu;//当前显示的下拉菜单
}
@end

@implementation MTTopMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString *currentcatetitle=[MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle;
        
        NSString *currentdistrict=[MTMetaDataTool sharedMTMetaDataTool].currentDistrict;
        
       _cateitem= [self addMenuItem:currentcatetitle?currentcatetitle:kAllCategoryText index:1];
        
       _distitem= [self addMenuItem:currentdistrict?currentdistrict:kAllDistrictText index:2];
        
      _shortitem=  [self addMenuItem:kAllShortTypeText index:3];
        
        //监听当前选择子分类发生改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentSubCategoryChange) name:kSubCategoryChangeNoti object:nil];
        
        //监听当前子商区发生改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentSubDistrictChange) name:kSubDistrictChangeNoti object:nil];
        
        //监听排序方式发生改变通知
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentShortChange) name:kShortChangeNoti object:nil];
        
        //监听城市发生改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentCityChange) name:kCityChangeNoti object:nil];
    }
    return self;
}

//当前子分类发生变化通知
-(void)currentSubCategoryChange
{
    if([MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle)
        [_cateitem setTitle:[MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle];
    else
        [_cateitem setTitle:kAllCategoryText];
}

//当前子商区发生变化通知
-(void)currentSubDistrictChange
{
    if([MTMetaDataTool sharedMTMetaDataTool].currentDistrict)
        [_distitem setTitle:[MTMetaDataTool sharedMTMetaDataTool].currentDistrict];
    else
        [_distitem setTitle:kAllDistrictText];
}

//当前排序发生改变通知
-(void)currentShortChange
{
    MTShortType *ordertype=[MTMetaDataTool sharedMTMetaDataTool].currentShortType;
    if(ordertype)
        [_shortitem setTitle:ordertype.name forState:UIControlStateNormal];
    else
        [_shortitem setTitle:kAllShortTypeText];
}

-(void)currentCityChange
{
   [_distitem setTitle:[MTMetaDataTool sharedMTMetaDataTool].currentDistrict];
}

//添加顶部菜单按钮
-(MTTopMeunItem *)addMenuItem:(NSString *)title index:(int)index
{
    MTTopMeunItem *menu=[[MTTopMeunItem alloc]init];
    menu.title=title;
    menu.tag=index;
    menu.frame=CGRectMake((index-1)*kTopMenuItemWidth, 0, 0, 0);
    [menu addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menu];
    return menu;
}

//菜单按钮点击事件
-(void)itemClick:(MTTopMeunItem *)item
{
     _selectedItem.selected=NO;
    if(_selectedItem==item)
    {
        _selectedItem=nil;
        //隐藏菜单
        [self hideDropMenu:item];
    }
    else
    {
        item.selected=YES;
        _selectedItem=item;
       
        [self showDropMenu:item];
    }
    
}

//显示下拉菜单
-(void)showDropMenu:(MTTopMeunItem *)item
{
    //是否要显示动画
    BOOL needshowanimation=_showdropmenu==nil;
    
    //先移除上一个菜单
    [_showdropmenu removeFromSuperview];
    if(item.tag==1)
    {
        if(_catemenu==nil)
        {
            _catemenu=[[MTCategoryMenu alloc]init];
            _catemenu.frame=_dropMenuView.bounds;
        }
        _showdropmenu=_catemenu;
    }
    else if(item.tag==2)
    {
        if(_dismenu==nil)
        {
            _dismenu=[[MTDistrictMeun alloc]init];
            _dismenu.frame=_dropMenuView.bounds;
        }
        _showdropmenu=_dismenu;
    }
    else{
        if(_shortMenu==nil)
        {
            _shortMenu=[[MTShortMenu alloc]init];
        }
        _showdropmenu=_shortMenu;
    }
    _showdropmenu.frame=_dropMenuView.bounds;
    
    //设置菜单隐藏时的block
    //防止内存泄露，在block里不能直接调用成员变量
    __unsafe_unretained MTTopMenu *menu=self;
    _showdropmenu.hideblock=^(){
        menu->_selectedItem.selected=NO;
        menu->_selectedItem=nil;
        menu->_showdropmenu=nil;
        
    };
    //添加菜单
    [_dropMenuView addSubview:_showdropmenu];
    
    //显示动画
    if(needshowanimation)
        [_showdropmenu showWithAnimation];
}

//隐藏下拉菜单
-(void)hideDropMenu:(MTTopMeunItem *)item
{
    [_showdropmenu hideWithAnimation];

}

//固定宽高
-(void)setFrame:(CGRect)frame
{
    frame.size.width=3*kTopMenuItemWidth;
    frame.size.height=kTopMenuItemHeight;
    
    [super setFrame:frame];
}


@end
