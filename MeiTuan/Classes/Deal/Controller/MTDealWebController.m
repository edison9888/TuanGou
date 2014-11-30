//
//  MTDealWebController.m
//  MeiTuan
//  图文详情
//  Created by 叶根长 on 14-10-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealWebController.h"
#import "MTDeal.h"
@interface MTDealWebController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    
    UIActivityIndicatorView *_indictor;//指示器
}
@end

@implementation MTDealWebController

-(void)loadView
{
    _webView=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate=self;
    _webView.scrollView.backgroundColor=kGlobaBg;
    _webView.backgroundColor=kGlobaBg;
    self.view=_webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *dealid=[_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location+1];
    
    //拦截图文详情链接
    NSString *url=[NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@",dealid];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    //添加指示器
    _indictor=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indictor.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    CGFloat x=self.view.frame.size.width/2;
    CGFloat y=self.view.frame.size.height/2;
    _indictor.center=CGPointMake(x, y);
    [_indictor startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //顶部增加100的滚动区域
    _webView.scrollView.contentInset=UIEdgeInsetsMake(70, 0, 0, 0);
    //自动往下滚100个像素
    _webView.scrollView.contentOffset=CGPointMake(0, -70);
    [_indictor stopAnimating];
//    NSString *str=[_webView stringByEvaluatingJavaScriptFromString:@"(document.getElementsByTagName('html')[0]).innerHTML"];
//    
//    NSLog(@"%@",str);
}

@end
