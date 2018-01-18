//
//  SLBLoadingView.m
//  loadingView
//
//  Created by SLB on 2017/12/28.
//  Copyright © 2017年 SLB. All rights reserved.
//

#import "SLBLoadingView.h"


#define loadingViewWidth     [UIScreen mainScreen].bounds.size.width
#define loadingViewHeight    [UIScreen mainScreen].bounds.size.height

@interface SLBLoadingView()

@property (nonatomic,strong) SLBLoadingView * custom;
@property (nonatomic, strong) UIImageView *heartImageView;
@property (nonatomic, strong) NSMutableArray *imageArr;

@end


@implementation SLBLoadingView

static SLBLoadingView *_instance = nil;
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}


+ (void)show {
    [[self shareInstance] showWithStatus:nil];
}

//加载视图
- (void)showWithStatus:(NSString*)text {
    
    _custom = [[SLBLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:_custom];
    
    
    UIView * customView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-75, [UIScreen mainScreen].bounds.size.height/2-50, 150, 120)];
    customView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [_custom addSubview:customView];
    customView.layer.masksToBounds = YES;
    customView.layer.cornerRadius = 15;
    
    
    _heartImageView = [[UIImageView alloc]init];
    [customView addSubview:_heartImageView];

    if (text == nil || [text isEqualToString:@""]) {

        _heartImageView.frame = CGRectMake(customView.frame.size.width/2-50, customView.frame.size.height/2-40 ,100, 80.0);
    } else {

        _heartImageView.frame = CGRectMake(customView.frame.size.width/2-50, 0 ,100, 80.0);

        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 150, 40)];
        label.text = text;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        [customView addSubview:label];
    }


    _imageArr = [[NSMutableArray alloc]initWithCapacity:7];
    for (int i=1; i<=5; i++)
    {
        [_imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"car%d.png",i]]];
    }
    _heartImageView.animationImages = _imageArr;
    _heartImageView.animationDuration = 0.4 ;
    _heartImageView.animationRepeatCount = MAXFLOAT;
    [_heartImageView startAnimating];
    
    
}



+(void)dismiss
{
    [[self shareInstance] hide];
}

-(void)hide {
    
    [_heartImageView stopAnimating];
    [_custom removeFromSuperview];
    _custom = nil;
    _heartImageView = nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return self;
}

-(void)dealloc {
    NSLog(@"销毁");
}




@end
