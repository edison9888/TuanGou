//
//  MTDeal.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-29.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDeal.h"
#import "MTRestriction.h"
#import "MTBusiness.h"

@implementation MTDeal

//根据字段创建团购对象
-(MTDeal *)initWithDict:(NSDictionary *)dict
{
    if (dict) {
        if(self==[super init])
        {
            self.deal_id=dict[@"deal_id"];
            self.title=dict[@"title"];
            self.desc=dict[@"description"];
            self.city=dict[@"city"];
            self.list_price=[dict[@"list_price"] floatValue];
            self.current_price=[dict[@"current_price"] floatValue];
            self.categories=dict[@"categories"];
            self.purchase_count=[dict[@"purchase_count"] intValue];
            self.purchase_deadline=dict[@"purchase_deadline"];
            self.publish_date=dict[@"publish_date"];
            self.image_url=dict[@"image_url"];
            self.s_image_url=dict[@"s_image_url"];
            self.deal_url=dict[@"deal_url"];
            self.deal_h5_url=dict[@"deal_h5_url"];
            self.notice=dict[@"notice"];
            self.details=dict[@"details"];
            //限制条件
            if (dict[@"restrictions"]) {
                MTRestriction *restriction=[[MTRestriction alloc]init];
                restriction.is_refundable=[dict[@"restrictions"][@"is_refundable"] boolValue];
                restriction.is_reservation_required=[dict[@"restrictions"][@"is_reservation_required"] boolValue];
                restriction.special_tips=dict[@"restrictions"][@"special_tips"];
                self.restriction=restriction;
            }
            //商铺信息
            if(dict[@"businesses"])
            {
                NSArray *buses=dict[@"businesses"];
                NSMutableArray *temp=[NSMutableArray array];
                for (NSDictionary *bus in buses) {
                    MTBusiness *b=[[MTBusiness alloc]initWithDict:bus];
                    [temp addObject:b];
                }
                _businesses=temp;
            }
        }
        return self;
    }
    return nil;
}

//重写isequal方法比对团购的id
-(BOOL)isEqual:(MTDeal *)deal
{
    return [self.deal_id isEqualToString:deal.deal_id];
}

//解档
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.deal_id=[aDecoder decodeObjectForKey:@"_deal_id"];
        self.desc=[aDecoder decodeObjectForKey:@"_desc"];
        self.title=[aDecoder decodeObjectForKey:@"_title"];
        self.image_url=[aDecoder decodeObjectForKey:@"_image_url"];
        self.current_price=[[aDecoder decodeObjectForKey:@"_current_price"] floatValue];
        self.purchase_count=[[aDecoder decodeObjectForKey:@"_purchase_count"] intValue];
        self.purchase_deadline=[aDecoder decodeObjectForKey:@"_purchase_deadline"];
        
    }
    return self;
}

//归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_deal_id forKey:@"_deal_id"];
    [aCoder encodeObject:_desc forKey:@"_desc"];
    [aCoder encodeObject:_title forKey:@"_title"];
    [aCoder encodeObject:_image_url forKey:@"_image_url"];
    [aCoder encodeObject:@(_current_price) forKey:@"_current_price"];
    [aCoder encodeObject:@(_purchase_count) forKey:@"_purchase_count"];
    [aCoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    
    
    
}

@end
