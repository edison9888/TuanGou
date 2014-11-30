//
//  MTCategoryMenu.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCategoryMenu.h"
#import "MTMetaDataTool.h"
#import "MTCategory.h"
#import "MTCategoryItem.h"

@interface MTCategoryMenu ()
{
    
}

@end

@implementation MTCategoryMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

//设置分类按钮
-(void)setUI
{
    NSArray *categorites=[MTMetaDataTool sharedMTMetaDataTool].allCategories;
    for (int i=0; i<categorites.count; i++) {
        MTCategoryItem *item=[[MTCategoryItem alloc]init];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.category=categorites[i];
        item.frame=CGRectMake(i*kDropMenuWidth, 0, 0, 0);
        [_scrollview addSubview:item];
    }
    _scrollview.contentSize=CGSizeMake(kDropMenuWidth*categorites.count, 0);
}

-(NSArray *)details:(MTDropMenuItem *)item
{
    MTCategoryItem *cateitem=((MTCategoryItem *)item);
    if(!cateitem.category.subcategories)
    {
        [MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle=cateitem.category.name;
    }
    return cateitem.category.subcategories;
}

//子菜单点击时候调用，设置全局的当前选择的子分类名称
-(void)detailClick:(NSString *)title
{
    [MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle=title;
    
    [super detailClick:title];
}

//返回当前全局选择的子分类名称
-(NSString *)getDetailTitile
{
    return [MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle;
}


-(void)selectedCityChange
{
    MyLog(@"MTCategoryMenu--%@",@"当前城市发生改变")
}

@end
