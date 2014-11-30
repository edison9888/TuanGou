//
//  MTDealTool.h
//  MeiTuan
//
//  Created by 叶根长 on 14-10-7.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <CoreLocation/CoreLocation.h>
/**
 请求团购数据成功
 */
typedef void (^dealsuccessBlock)(id result);

/**
 请求团购数据失败
 */
typedef  void (^dealfailureBlock)(NSError *error);

@interface MTDealTool : NSObject

//单例
singleton_interface(MTDealTool)

/**
 获取团购数据
 @param page 请求页码
 @param successBlock 请求成功后调用的block
 @param failureBlock 请求失败后调用的block
 */
-(void)getDealData:(int)page successBlock:(dealsuccessBlock)successBlock failureBlock:(dealfailureBlock)failureBlock;

/**
 根据经纬度获取团购信息
 @param location 经纬度信息
 @param successBlock 请求成功后调用的block
 @param failureBlock 请求失败后调用的block
 */
-(void)getDealDataWithLocation:(CLLocationCoordinate2D)location successBlock:(dealsuccessBlock)successBlock failureBlock:(dealfailureBlock)failureBlock;

/**
 根据团购信息ID获取指定团购信息
 
 @param ID 团购ID
 @param successBlock 请求成功后调用的block
 @param failureBlock 请求失败后调用的block
 */
-(void)getDealDataWithID:(NSString *)ID successBlock:(dealsuccessBlock)successBlock failureBlock:(dealfailureBlock)failureBlock;

@end
