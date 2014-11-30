//
//  MTLocationTool.m
//  MeiTuan
//
//  Created by 叶根长 on 14-10-25.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTLocationTool.h"
#import "Singleton.h"
#import <CoreLocation/CoreLocation.h>
#import "MTMetaDataTool.h"
#import "MTCity.h"
@interface MTLocationTool ()<CLLocationManagerDelegate>
{
    //定位管理
    CLLocationManager *_mgr;
    
    //地理编码类
    CLGeocoder *_geo;
}
@end

@implementation MTLocationTool

singleton_implementation(MTLocationTool)

-(id)init
{
    if (self=[super init]) {
        _mgr=[[CLLocationManager alloc]init];
        _mgr.delegate=self;
        _geo=[[CLGeocoder alloc]init];
    }
    
    return self;
}

-(void)startLocalation
{
    [_mgr startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMsg=nil;
    if (error.code==kCLErrorDenied) {
        errorMsg=@"访问被拒绝,请运行本程序使用定位服务";
    }
    else if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
    else
        errorMsg=[error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"定位失败"
                                                      message:errorMsg delegate:self cancelButtonTitle:@"好"otherButtonTitles:nil, nil];
    [alertView show];
   
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //定位一次成功后停止继续定位
    [_mgr stopUpdatingLocation];
    //选择第一个位置，最准确
    CLLocation *clo=locations[0];
    
    //反地理编码，根据经纬度获取地理名称
    [_geo reverseGeocodeLocation:clo completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks&&error==nil) {
            CLPlacemark *mark=placemarks[0];
            //获取城市名称XX市
            NSString *cityst=mark.addressDictionary[@"City"];
            if (cityst) {
                cityst=[cityst substringToIndex:cityst.length-1];
                //获取所有城市
                NSArray *cities=[MTMetaDataTool sharedMTMetaDataTool].allCities;
                for (MTCity *city in cities) {
                    if([city.name isEqualToString:cityst])
                    {
                        //设置当前选中城市
                        [MTMetaDataTool sharedMTMetaDataTool].currentCity=city;
                        _loclationCity=city;
                        break;
                    }
                }
            }
        }
        else if (error)
        {
            UIAlertView *dialog=[[UIAlertView alloc]initWithTitle:@"错误" message:@"定位出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [dialog show];
        }
    }];
    
}



@end
