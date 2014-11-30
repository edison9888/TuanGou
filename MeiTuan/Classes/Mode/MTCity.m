//
//  MTCity.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTCity.h"
#import "NSObject+Value.h"
#import "MTDistrict.h"
@implementation MTCity

-(void)setDistricts:(NSArray *)districts
{
    if(districts)
    {
        NSMutableArray *array=[NSMutableArray array];
        for (NSDictionary *dic in districts) {
            //如果字典数据不是字典，而是模型，则直接赋值给属性并返回
            if(![dic isKindOfClass:[NSDictionary class]])
            {
                _districts=districts;
                return;
            }
            MTDistrict *city=[[MTDistrict alloc]init];
            [city setValues:dic];
            [array  addObject:city];
        }
        _districts=array;
    }
    else
        _districts=districts;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.districts=[aDecoder decodeObjectForKey:@"districts"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:_districts forKey:@"districts"];
}

@end
