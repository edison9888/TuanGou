//
//  MTCollectController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-17.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCollectController.h"
#import "MTCollectTool.h"
#import "MTBaseDealListController.h"
@interface MTCollectController ()

@end

@implementation MTCollectController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"收藏";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectChange) name:kCollectChangeNoti object:nil];
}

-(void)collectChange
{
    [self.collectionView reloadData];
}

-(NSArray *)totalDeals
{
    return [MTCollectTool sharedMTCollectTool].collectDeals;
}


@end
