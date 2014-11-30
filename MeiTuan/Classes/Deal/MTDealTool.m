//
//  MTDealTool.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-7.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDealTool.h"
#import "Singleton.h"
#import "MTMetaDataTool.h"
#import "DPAPI.h"
#import "MTCategory.h"
#import "MTCity.h"
#import "MTDistrict.h"
#import "MTShortType.h"

typedef void (^requestBlock)(id result,NSError *error);

@interface MTDealTool ()<DPRequestDelegate>
{
    NSMutableDictionary *_dictrequst;//请求的的字典集合
}
@end

@implementation MTDealTool

-(id)init
{
    _dictrequst=[NSMutableDictionary dictionary];
    return [super init];
}

singleton_implementation(MTDealTool)

#pragma mark 外部调用，根据页码请求数据
-(void)getDealData:(int)page successBlock:(dealsuccessBlock)successBlock failureBlock:(dealfailureBlock)failureBlock
{
    //拼接请求参数
    NSMutableDictionary *dictparam=[NSMutableDictionary dictionary];
    //城市
    if([MTMetaDataTool sharedMTMetaDataTool].currentCity)
        [dictparam setObject:[MTMetaDataTool sharedMTMetaDataTool].currentCity.name forKey:@"city"];
    //商区
    NSString *dictrict=[MTMetaDataTool sharedMTMetaDataTool].currentDistrict;
    if(dictrict&& ![dictrict isEqualToString:kAllDistrictText])
        [dictparam setObject:[MTMetaDataTool sharedMTMetaDataTool].currentDistrict forKey:@"region"];
    //分类名称
    NSString *cate=[MTMetaDataTool sharedMTMetaDataTool].currentCategoryTitle;
    if(cate&&![cate isEqualToString:kAllCategoryText])
        [dictparam setObject:cate forKey:@"category"];
    //排序方式
    int shortype=[MTMetaDataTool sharedMTMetaDataTool].currentShortType.index;
    if (shortype) {
        [dictparam setObject:[NSNumber numberWithInt:shortype] forKey:@"sort"];
    }
    [dictparam setObject:@(page) forKey:@"page"];
    [dictparam setObject:@20 forKey:@"limit"];
   
    //开始请求数据
    [self requstWithParam:dictparam url:@"v1/deal/find_deals" Block:^(id result, NSError *error) {
        if(error)
        {
            //失败
            if(failureBlock)
            {
                failureBlock(error);
            }
        }
        else
        {
            //成功
            if(successBlock)
            {
                successBlock(result);
            }
        }
    }];
}

/**
 根据经纬度查找周边团购信息
 */
-(void)getDealDataWithLocation:(CLLocationCoordinate2D)location successBlock:(dealsuccessBlock)successBlock failureBlock:(dealfailureBlock)failureBlock
{
    //拼接请求参数
    NSMutableDictionary *dictparam=[NSMutableDictionary dictionary];
    //城市
    if([MTMetaDataTool sharedMTMetaDataTool].currentCity)
        [dictparam setObject:[MTMetaDataTool sharedMTMetaDataTool].currentCity.name forKey:@"city"];
    [dictparam setObject:@(location.latitude) forKey:@"latitude"];
    [dictparam setObject:@(location.longitude) forKey:@"longitude"];
    
    //开始请求数据
    [self requstWithParam:dictparam url:@"v1/deal/find_deals" Block:^(id result, NSError *error) {
        if(error)
        {
            //失败
            if(failureBlock)
            {
                failureBlock(error);
            }
        }
        else
        {
            //成功
            if(successBlock)
            {
                successBlock(result);
            }
        }
    }];
}

/**
 获取指定团购信息
 */
-(void)getDealDataWithID:(NSString *)ID successBlock:(dealsuccessBlock)successBlock failureBlock:(dealfailureBlock)failureBlock
{
    if(ID)
    {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setValue:ID forKey:@"deal_id"];
        [self requstWithParam:params url:@"v1/deal/get_single_deal" Block:^(id result, NSError *error) {
            if(error)
            {
                //失败
                if(failureBlock)
                {
                    failureBlock(error);
                }
            }
            else
            {
                //成功
                if(successBlock)
                {
                    successBlock(result);
                }
            }
        }];
    }
}

#pragma mark 封装所有服务器请求方法
-(void)requstWithParam:(NSMutableDictionary *)params url:(NSString *)url Block:(requestBlock)block
{
    DPAPI *aip=[[DPAPI alloc]init];
    DPRequest *request=[aip requestWithURL:url params:params delegate:self];
    [_dictrequst setObject:block forKey:[request description]];
}


#pragma mark 请求服务器成功后调用的方法
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    requestBlock block=_dictrequst[[request description]];
    if(block)
    {
        block(result,nil);
    }
}

#pragma mark 请求服务器失败后调用的方法
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    requestBlock block=_dictrequst[[request description]];
    if(block)
    {
        block(nil,error);
    }
}

@end
