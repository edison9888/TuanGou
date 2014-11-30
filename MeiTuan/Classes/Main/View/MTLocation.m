//
//  MTLocation.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTLocation.h"
#import "MTCityListController.h"
#import "MTCity.h"
#import "MTMetaDataTool.h"
#import "MTLocationTool.h"
@interface MTLocation ()
{
    //城市查询弹出层
    UIPopoverController *_popover;
    
    //定位中指示器
    UIActivityIndicatorView *_indictator;
}
@end

@implementation MTLocation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自动伸缩
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        //设置图片
        self.icon=@"ic_district.png";
        self.selectedicon=@"ic_district_hl.png";
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:16];
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(locationclick) forControlEvents:UIControlEventTouchDown];
        
        //监听当前城市发生改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedCityChange) name:kCityChangeNoti object:nil];
        
        //开始定位
        [[MTLocationTool sharedMTLocationTool] startLocalation];
        
        _indictator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indictator.center=self.center;
        [_indictator startAnimating];
        [self addSubview:_indictator];
        
    }
    return self;
}

#pragma mark 监听屏幕旋转
-(void)screenRotare
{
    if(_popover.isPopoverVisible)
    {
        [_popover dismissPopoverAnimated:NO];
        
        [self performSelector:@selector(showpopover) withObject:nil afterDelay:0.2];
    }
}

//对象销毁前移除系统通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//显示城市旋转框
-(void)showpopover
{
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)selectedCityChange
{
    [_indictator stopAnimating];
    MTCity *city=[MTMetaDataTool sharedMTMetaDataTool].currentCity;
    [self setTitle:city.name forState:UIControlStateNormal];
    
    [_popover dismissPopoverAnimated:YES];
}


-(void)locationclick
{
    MTCityListController *city=[[MTCityListController alloc]init];
    UIPopoverController *popover=[[UIPopoverController alloc]initWithContentViewController:city];
    popover.popoverContentSize=CGSizeMake(320, 480);
    [popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    _popover=popover;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //监听屏幕旋转的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotare) name:UIDeviceOrientationDidChangeNotification object:nil];
   

}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height*(1-0.5);
    CGFloat y=contentRect.size.height-h;
    
    return CGRectMake(0, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height*0.5;
    return CGRectMake(0, 5, w, h);
}


@end
