//
//  CommandHeader.h
//  MeiTuan
//
//  Created by 叶根长 on 14-9-16.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#define MeiTuan_CommandHeader_h
#define MeiTuan_CommandHeader_h

//判断是否ios系统
#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)

//获取沙盒文档路径
#define kDocPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

//拼接文档路径
#define kAppendDocPath(filename) [kDocPath stringByAppendingPathComponent:filename]

//DockItem的宽高
#define kDockItemWidth 100
#define kDockItemHeight 80

//顶部菜单的宽度
#define kTopMenuItemWidth 100
#define kTopMenuItemHeight 44

//导航栏下拉菜单项的高度
#define kDropMenuHight 60
#define kDropMenuWidth 100

//导航栏明细菜单的宽高
#define kDropDetailMenuHight 60

//团购项显示宽高
#define kDealItemWidth 250
#define kDealItemWidth 250

//遮盖层的透明度
#define kAlpha 0.4
//显示隐藏动画时长
#define kAnimationTime 0.7

//当前城市发生改变的通知ID
#define kCityChangeNoti @"MTselectedCityChangeNoti"
//当前选择子分类发生改变的通知ID
#define kSubCategoryChangeNoti @"MTselectedSubCategoryChangeNoti"
//当前选择子商区发生改变的通知ID
#define kSubDistrictChangeNoti @"MTselectedSubDistrictChangeNoti"
//当前选择的排序方式发生改变通知ID
#define kShortChangeNoti @"MTselectedShortChangeNoti"

//收藏数据发生改变发出通知
#define kCollectChangeNoti @"CollectChangeNoti"

#define kAllDistrictText @"全部商区"
#define kAllCategoryText @"全部分类"
#define kAllShortTypeText @"默认排序"

//全局背景颜色
#define kGlobaBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]

//自定义输出宏 替换NSLog();
#ifdef DEBUG
//调试状态下替换NSLog的功能
#define MyLog(...) NSLog(__VA_ARGS__);
#else
//编译状态下替换成空白,提高性能
#define MyLog(...)
#endif

//设置字体大小
#define kFont(size) [UIFont systemFontOfSize:(size)]
