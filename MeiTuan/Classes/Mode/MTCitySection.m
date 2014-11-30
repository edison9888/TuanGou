//
//  MTCitySection.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCitySection.h"
#import "MTCity.h"
#import "NSObject+Value.h"
@implementation MTCitySection

-(void)setCities:(NSArray *)cities
{
    //当cities为空或者里面装的模型数据,则直接赋值
    id obj=[cities lastObject];
    if(![obj isKindOfClass:[NSDictionary class]])
    {
        _cities=cities;
        return;
    }
    
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic in cities) {
        MTCity *city=[[MTCity alloc]init];
        [city setValues:dic];
        [array  addObject:city];
    }
    _cities=array;
    
}

@end
