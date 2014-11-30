//
//  MTMoreItem.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTMoreItem.h"
#import "MtmoreController.h"
#import "MTNavigationController.h"
@implementation MTMoreItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自动伸缩
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        //设置图片
        self.icon=@"ic_more.png";
        self.selectedicon=@"ic_more_hl.png";
        
        [self addTarget:self action:@selector(moreclick) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void)moreclick
{
    MTMoreController *more=[[MTMoreController alloc]init];
    more.closeButton=self;
    MTNavigationController *nav=[[MTNavigationController alloc]initWithRootViewController:more];
    //设置窗口为表单模式，居中显示，非全屏,默认为全屏
    nav.modalPresentationStyle=UIModalPresentationFormSheet;
    //弹出模态窗口
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
