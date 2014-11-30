//
//  MTBusiness.m
//  MeiTuan
//  商铺信息
//  Created by 叶根长 on 14-10-25.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTBusiness.h"

@implementation MTBusiness

-(MTBusiness *)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.name=dict[@"name"];
        self.city=dict[@"city"];
        self.businessID=[dict[@"id"] intValue];
        self.h5_url=dict[@"h5_url"];
        self.latitude=[dict[@"latitude"] floatValue];
        self.longitude=[dict[@"longitude"] floatValue];
    }
    
    return self;
}

@end
