//
//  MTMineController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-17.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTMineController.h"

@interface MTMineController ()

@end

@implementation MTMineController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=kGlobaBg;

    self.title=@"我的";
}


@end
