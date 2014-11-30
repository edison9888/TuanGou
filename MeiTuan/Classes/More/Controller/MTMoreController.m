//
//  MTMoreController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-18.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTMoreController.h"

@interface MTMoreController ()

@end

@implementation MTMoreController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    self.navigationItem.leftBarButtonItem=done;
    
    //意见反馈
    UIBarButtonItem *advice=[[UIBarButtonItem alloc]initWithTitle:@"意见反馈" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem=advice;
}

- (void)goback
{
    [self dismissViewControllerAnimated:YES completion:^{
        _closeButton.enabled=YES;
    }];
}


@end
