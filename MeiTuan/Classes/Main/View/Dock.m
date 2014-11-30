//
//  Dock.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "Dock.h"
#import "MTDockItem.h"
#import "MTMoreItem.h"
#import "MTLocation.h"
#import "MTTabItem.h"
#import "MTCityListController.h"
@interface Dock ()
{
    MTTabItem *_selectedItem;
    UIPopoverController *_popover;
}

@end

@implementation Dock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
        self.backgroundColor=[UIColor orangeColor];
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
    [self addLogo];
    
    [self addTabs];
    
    [self addMore];
    
    [self addLocation];
    
    
}


#pragma mark 添加logo
-(void)addLogo
{
    UIImageView *logo=[[UIImageView alloc]init];
    UIImage *img=[UIImage imageNamed:@"ic_logo.png"];
    CGFloat scale=0.8;
    logo.bounds=CGRectMake(0, 0, img.size.width*scale,img.size.height*scale);
    logo.center=CGPointMake(kDockItemWidth*0.5, kDockItemHeight*0.5);
    logo.image=img;
    [self addSubview:logo];

}



#pragma mark 添加TabItem
-(void)addTabs
{
    //团购
    [self addTabItem:@"ic_deal.png" hlimg:@"ic_deal_hl.png" index:1];
    //地图
    [self addTabItem:@"ic_map.png" hlimg:@"ic_map_hl.png" index:2];
    //收藏
    [self addTabItem:@"ic_collect.png" hlimg:@"ic_collect_hl.png" index:3];
    //我的
    [self addTabItem:@"ic_mine.png" hlimg:@"ic_mine_hl.png" index:4];
    
    UIImageView *line=[[UIImageView alloc]init];
    line.image=[UIImage imageNamed:@"separator_tabbar_item.png"];
    line.frame=CGRectMake(0, kDockItemHeight*5, kDockItemWidth, 2);
    [self addSubview:line];
}

-(void)addTabItem:(NSString *)img hlimg:(NSString *)hlimg index:(int)index
{
    MTTabItem *item=[[MTTabItem alloc]init];
    item.tag=index-1;
    item.frame=CGRectMake(0, kDockItemHeight*index, 0, 0);
    [item seticon:img selectedicon:hlimg];
    [item addTarget:self action:@selector(tabItemClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:item];
    if(index==1)
        [self tabItemClick:item];
}

-(void)tabItemClick:(MTTabItem *)item
{
    _selectedItem.enabled=YES;
    item.enabled=NO;
    int from=_selectedItem.tag;
    int to =item.tag;
        _selectedItem=item;
    
    if(self.delegate)
    {
        if([self.delegate respondsToSelector:@selector(dock:tabChangeFrom:to:)])
        {
            [self.delegate dock:self tabChangeFrom:from to:to];
        }
    }
}


#pragma mark 添加定位按钮
-(void)addLocation
{
   
    MTLocation *location=[[MTLocation alloc]init];
    CGFloat y=self.frame.size.height-kDockItemHeight*2;
    location.frame=CGRectMake(0, y, 0, 0);
    [self addSubview:location];
}


#pragma mark 添加更多按钮
-(void)addMore
{
    MTMoreItem *more=[[MTMoreItem alloc]init];
    [more addTarget:self action:@selector(moreclick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat y=self.frame.size.height-kDockItemHeight;
    more.frame=CGRectMake(0, y, 0, 0);
    [self addSubview:more];
}

//点击更多
-(void)moreclick:(MTDockItem *)item
{
    item.enabled=NO;
}

#pragma mark 固定宽度
-(void)setFrame:(CGRect)frame
{
    frame.size.width=100;
    [super setFrame:frame];
}

@end
