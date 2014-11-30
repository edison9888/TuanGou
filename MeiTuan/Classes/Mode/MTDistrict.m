//
//  MTDistrcts.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDistrict.h"
@implementation MTDistrict

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.neighborhoods=[aDecoder decodeObjectForKey:@"neighborhoods"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:_neighborhoods forKey:@"neighborhoods"];
}

@end
