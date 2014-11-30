//
//  MTDropMenu.m
//  MeiTuan
//  导航栏顶部菜单的下来菜单项
//  Created by 叶根长 on 14-9-21.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//



#import "MTDropMenu.h"
#import "MTDropDetailMenu.h"
#import "MTDropMenuItem.h"

@interface MTDropMenu ()
{
    UIView *_coverview;//蒙版
    UIView *_contentview;//存放scrolview和detailview
    MTDropMenuItem *_selectedItem;
}
@end

@implementation MTDropMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        //蒙版
        UIView *coverview=[[UIView alloc]init];
        [coverview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideWithAnimation)]];
        coverview.backgroundColor=[UIColor blackColor];
        coverview.alpha=kAlpha;
        coverview.autoresizingMask=self.autoresizingMask;
        coverview.frame=self.bounds;
        [self addSubview:coverview];
        _coverview=coverview;
        
        _contentview=[[UIView alloc]init];
        _contentview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        _contentview.frame=CGRectMake(0, 0, self.frame.size.width, kDropMenuHight);
        [self addSubview:_contentview];
        
        //滚动条
        UIScrollView *scrollview=[[UIScrollView alloc]init];
        scrollview.showsHorizontalScrollIndicator=NO;
        scrollview.backgroundColor=[UIColor whiteColor];
        scrollview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        scrollview.frame=CGRectMake(0, 0, self.frame.size.width, kDropMenuHight);
        [_contentview addSubview:scrollview];
        _scrollview=scrollview;
        

        //监听当前选择城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedCityChange) name:kCityChangeNoti object:nil];
    }
    return self;
}

-(void)itemClick:(MTDropMenuItem *)item
{
    _selectedItem.selected=NO;
    item.selected=YES;
    _selectedItem=item;
    //子抬头数据源
    NSArray *array=[self details:item];
     CGRect frame=_contentview.frame;
    if(array.count)
    {
        if (_detailView==nil) {
            //创建子菜单
            _detailView=[[MTDropDetailMenu alloc]init];
            //为了内存管理，block要使用当前对象self，所以定义一个 __unsafe_unretained变量让block里面调用
            __unsafe_unretained MTDropMenu *dorpmeun=self;
            _detailView.btnclickBlock=^(NSString *title)
            {
                [dorpmeun detailClick:title];
            };
            
            //获取当前子菜单选中的文字
            _detailView.getbtnclickBlock=^()
            {
                return  [dorpmeun getDetailTitile];
            };
            
            _detailView.frame=CGRectMake(0, kDropMenuHight,self.frame.size.width, 0);
            [_detailView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:nil]];
        }
        //设置子菜单数据源
        _detailView.details=array;
        if(_detailView.superview==nil)
            [_detailView showWithAnimation];
        //插入子菜单
        [_contentview insertSubview:_detailView belowSubview:_scrollview];
          frame.size.height=_scrollview.frame.size.height+_detailView.frame.size.height;
         _contentview.frame=frame;
    }
    else //如果没有子标题，则隐藏子标题
    {
        [_detailView hideWithAnimation];
        frame.size.height=_scrollview.frame.size.height;
         _contentview.frame=frame;
        //如果没有子标题，隐藏菜单
        [self hideWithAnimation];
    }
   
}

//子菜单数组,子类实现
-(NSArray *)details:(MTDropMenuItem *)item
{
    return nil;
}

//子菜单点击时候调用，子类实现
-(void)detailClick:(NSString *)title
{
    [self hideWithAnimation];
}

//获取当前菜单的子菜单要选择的文字，子类实现
-(NSString *)getDetailTitile
{
    return nil;
}


//对象销毁时，是否所有通知的观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//伴随动画显示
-(void)showWithAnimation
{
    //1先让_scrollview向上平移
    CGAffineTransform tranfrom=CGAffineTransformMakeTranslation(0, -_contentview.frame.size.height);
    _contentview.transform=tranfrom;
    //先让蒙版的透明度为0
    _coverview.alpha=0;
    [UIView animateWithDuration:kAnimationTime animations:^{
        //清空所有形变属性
        _contentview.transform=CGAffineTransformIdentity;
        _coverview.alpha=kAlpha;
    }];
}


//伴随动画隐藏
-(void)hideWithAnimation
{
    if(_hideblock)
    {
        _hideblock();
    }

    [UIView animateWithDuration:kAnimationTime animations:^{
        //清空所有形变属性
        CGAffineTransform tranfrom=CGAffineTransformMakeTranslation(0, -_contentview.frame.size.height);
        _contentview.transform=tranfrom;
        _coverview.alpha=0;
    } completion:^(BOOL finished) {
        _contentview.transform=CGAffineTransformIdentity;
        [self removeFromSuperview];
       
    }];
}

//当前城市发生改变通知
-(void)selectedCityChange
{
    //留给子类重写
}

@end
