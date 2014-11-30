//
//  MTDealInfoController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealInfoController.h"
#import "MTDealInfoHeaderView.h"
#import "MTDealTool.h"
#import "MTDeal.h"
#import "MTRestriction.h"
#import "MTInfoTextView.h"
#import "MTRestriction.h"
#define kMargin 20 //垂直方向间距
@interface MTDealInfoController ()
{
    UIScrollView *_scrollview;

    MTDealInfoHeaderView *_headerview;    //头部信息
}
@end

@implementation MTDealInfoController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addScrollView];
    
    //添加头部控件
    [self addHeaderView];
    
    //获取详细团购信息
    [self performSelector:@selector(getData) withObject:nil afterDelay:2];
}

-(void)addScrollView
{
    //添加ScrollView
    _scrollview=[[UIScrollView alloc]init];
    _scrollview.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    _scrollview.bounds=CGRectMake(0, 0, 430, self.view.frame.size.height);
    _scrollview.center=CGPointMake(self.view.center.x, self.view.center.y);
    _scrollview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_scrollview];
}

//添加头部信息
-(void)addHeaderView
{
   MTDealInfoHeaderView *header=[MTDealInfoHeaderView dealInfoHeaderView];
   
    header.frame=CGRectMake(0, 0,_scrollview.frame.size.width, 400);
     header.deal=_deal;
    [_scrollview addSubview:header];
    _headerview=header;
}

//获取团购明细
-(void)getData
{
    [[MTDealTool sharedMTDealTool] getDealDataWithID:_deal.deal_id successBlock:^(id result) {
        NSArray *array=result[@"deals"];
        if([NSString stringWithFormat:@"%@",result[@"deals"]] &&array.count>0)
        {
            NSDictionary *dict=result[@"deals"][0];
            MTDeal *deal=[[MTDeal alloc]initWithDict:dict];
            _deal=deal;
            _headerview.deal=deal;
            //展示详情数据
            [self showDetail];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
}

//展示详情数据
-(void)showDetail
{
    //1 团购详情
    if (_deal.details.length!=0) {
        [self AddTextView:@"ic_content.png" title:@"团购详情" content:_deal.details];
    }
    //2 购买须知
    if (_deal.restriction.special_tips.length!=0) {
        [self AddTextView:@"ic_tip.png" title:@"购买须知" content:_deal.restriction.special_tips];
    }
    //3 重要通知
    if (_deal.notice.length!=0) {
        [self AddTextView:@"ic_content.png" title:@"重要通知" content:_deal.notice];
    }
}

-(void)AddTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if(content.length==0)return;
    
    MTInfoTextView *textview=[MTInfoTextView InfoTextView];
    textview.title=title;
    textview.content=content;
    textview.icon=icon;
    //最后一个子控件
    UIView *lastview=[_scrollview.subviews lastObject];
    CGFloat y=CGRectGetMaxY(lastview.frame)+kMargin;
    textview.frame=CGRectMake(0, y,_scrollview.frame.size.width, textview.frame.size.height);
    [_scrollview addSubview:textview];
    
    //设置Scrollview的ContentSize
    y=CGRectGetMaxY(textview.frame);
    _scrollview.contentSize=CGSizeMake(0, y+kMargin);
}

@end
