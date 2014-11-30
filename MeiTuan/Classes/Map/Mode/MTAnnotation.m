//
//  MTAnnotation.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-25.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTAnnotation.h"
#import "MTDeal.h"
#import "MTMetaDataTool.h"
@implementation MTAnnotation

-(void)setDeal:(MTDeal *)deal
{
    _deal=deal;
    for (NSString *c in deal.categories) {
        NSString *icon=[[MTMetaDataTool sharedMTMetaDataTool] iconWithCategory:c];
        if(icon)
        {
            icon=[icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            _image=[UIImage imageNamed:icon];
            break;
        }
        
    }
}

@end
