//
//  MTSearchResutController.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-20.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTSearchResutController.h"
#import "MTMetaDataTool.h"
#import "MTCity.h"
#import "PinYin4Objc.h"
@interface MTSearchResutController ()
{
    NSMutableArray *_resultCitise;//所有搜索到的城市
}
@end

@implementation MTSearchResutController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _resultCitise=[NSMutableArray array];
    
    HanyuPinyinOutputFormat *fmt=[[HanyuPinyinOutputFormat alloc]init];
    //拼音字母为大写
    fmt.caseType=CaseTypeUppercase;
    //不显示声调
    fmt.toneType=ToneTypeWithoutTone;
    fmt.vCharType=VCharTypeWithUUnicode;
    
    NSString *pintin=[PinyinHelper toHanyuPinyinStringWithNSString:@"宁波" withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
    
    MyLog(@"%@",pintin);
}

-(void) setSearchText:(NSString *)searchText
{
    //搜索前先清空历史结果
    [_resultCitise removeAllObjects];
    
    _searchText=searchText;
    HanyuPinyinOutputFormat *fmt=[[HanyuPinyinOutputFormat alloc]init];
    //拼音字母为大写
    fmt.caseType=CaseTypeUppercase;
    //不显示声调
    fmt.toneType=ToneTypeWithoutTone;
    fmt.vCharType=VCharTypeWithUUnicode;
    
    //筛选数据
    NSArray *cities=[MTMetaDataTool sharedMTMetaDataTool].allCities;
    [cities enumerateObjectsUsingBlock:^(MTCity *city, NSUInteger idx, BOOL *stop) {
       
       //获取城市名称的拼音,并且以#号分割
       NSString *pintin=[PinyinHelper toHanyuPinyinStringWithNSString:city.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
       //获取拼音的首字母
        //分割字符串
        NSArray *words=[pintin componentsSeparatedByString:@"#"];
        NSMutableString *pingyinheader=[NSMutableString string];
        //拼接拼音首字母
        for (NSString *word in words) {
            [pingyinheader appendString:[word substringToIndex:1]];
        }
        
        //分割完后去掉拼音中的#号去掉
        pintin=[pintin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        //匹配结果
        //城市名中包含搜索条件
        //城市名称拼音中包含搜索条件
        //城市名称拼音首字母包含搜索条件
        if ([city.name rangeOfString:searchText].length>0
            || ([pintin rangeOfString:searchText.uppercaseString].length>0)
            || ([pingyinheader rangeOfString:searchText.uppercaseString].length>0))
        {
            [_resultCitise addObject:city];
        }
    }];
    //刷新表格
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _resultCitise.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    MTCity *city=_resultCitise[indexPath.row];
    cell.textLabel.text=city.name;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d条搜索结果",_resultCitise.count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MTCity *city=_resultCitise[indexPath.row];
    //设置当前选择城市
    [MTMetaDataTool sharedMTMetaDataTool].currentCity=city;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
