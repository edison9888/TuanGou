//
//  MTDropDetailMenu.m
//  MeiTuan
//
//  Created by 叶根长 on 14-9-22.
//  Copyright (c) 2014年 叶根长. All rights reserved.
//

#import "MTDropDetailMenu.h"
#import "UIImage+YGCCategory.h"
#import "MTMetaDataTool.h"

@interface SubtitleBtn : UIButton

@end

@implementation SubtitleBtn

-(void)drawRect:(CGRect)rect
{
    if(self.selected)
    {
        CGRect titlef=self.titleLabel.frame;
        titlef.origin.x -=5;
        titlef.origin.y -=5;
        titlef.size.height+=10;
        titlef.size.width +=10;
        
        [[UIImage resizedImage:@"slider_filter_bg_active.png"] drawInRect:titlef];
    }
}

@end

@interface MTDropDetailMenu ()
{
    NSMutableArray *_arraybtns;//子菜单按钮集合
    
    UIButton *_selectedbutton;//被选择按钮；
}
@end

@implementation MTDropDetailMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image=[UIImage resizedImage:@"bg_subfilter_other.png"];
        self.userInteractionEnabled=YES;
        self.clipsToBounds=YES;
        self.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:nil]];
        _arraybtns=[NSMutableArray array];
    }
    return self;
}

//设置子菜单数据
-(void)setDetails:(NSArray *)details
{
    _details=details;
    [self showDetail];
}

//显示子菜单按钮
-(void)showDetail
{
    CGRect frame=self.frame;
    if(_details.count)
    {
        int count=_details.count;
        int column=6;//列数
        int row=count%column==0?count/column:count/column+1;//行数
        
        //根据行数计算菜单的高度
        frame.size.height=row*kDropMenuHight;
        
        //计算每个菜单的宽度
        CGFloat w=frame.size.width/6;
        //每个菜单的高度
        CGFloat h=kDropDetailMenuHight;
        frame.size.height=row*h+10;
        for (int i=0; i<count; i++) {
            UIButton *button=nil;
            if(i>=_arraybtns.count)
            {
                button=[SubtitleBtn buttonWithType:UIButtonTypeCustom];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
//                [button setBackgroundImage:[UIImage imageNamed:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
                button.titleLabel.font=kFont(15);
                [_arraybtns addObject:button];
                
            }
            else
                button=_arraybtns[i];
            
            int col=i%column;
            CGFloat x=col*w;
            CGFloat rowindex=i/column;
            CGFloat y=rowindex*h;
            if (rowindex==0) {
                y+=10;
            }
            [button setTitle:_details[i] forState:UIControlStateNormal];
            //当前选择的分类名称
            NSString *selecttitle=nil;
            if([self getbtnclickBlock])
            {
                selecttitle=self.getbtnclickBlock();
                //如果当前按钮的文字等于用户之前选择的分类子菜单，则该按钮为选择状态
                if([_details[i] isEqualToString:selecttitle])
                   [self btnclick:button];
                else
                    button.selected=NO;
            }
            else
                button.selected=NO;
            
            button.frame=CGRectMake(x, y, self.frame.size.width/6, h);
            button.hidden=NO;
            [self addSubview:button];
            }
        
        if (_details.count<_arraybtns.count) {
            for (int i=_details.count; i<_arraybtns.count;i++)
            {
                ((UIButton *)_arraybtns[i]).hidden=YES;
            }
        }
        
    }
    else
        frame.size.height=0;
    [UIView animateWithDuration:0.7 animations:^{
        self.frame=frame;
    }];
   
}

//按钮点击事件
-(void)btnclick:(UIButton *)btn
{
    _selectedbutton.selected=NO;
    
    btn.selected=YES;
    
    _selectedbutton=btn;
    
    //按钮点击调用Block
    if(self.btnclickBlock)
    {
        self.btnclickBlock([btn titleForState:UIControlStateNormal]);
    }
}

//屏幕旋转时调用
-(void)layoutSubviews
{
     [self showDetail];
}


//伴随动画显示
-(void)showWithAnimation
{
    CGAffineTransform tranform=CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.transform=tranform;
    [UIView animateWithDuration:0.7 animations:^{
        self.transform=CGAffineTransformIdentity;
    }];
}


//伴随动画隐藏
-(void)hideWithAnimation
{
   
    [UIView animateWithDuration:0.7 animations:^{
        CGAffineTransform tranform=CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.transform=tranform;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.transform=CGAffineTransformIdentity;
        CGRect frame=self.frame;
        frame.size.height=0;
        self.frame=frame;
    }];
}

@end
