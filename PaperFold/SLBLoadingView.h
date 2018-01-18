//
//  SLBLoadingView.h
//  loadingView
//
//  Created by SLB on 2017/12/28.
//  Copyright © 2017年 SLB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBLoadingView : UIView

+(instancetype)shareInstance;

+ (void)show;
- (void)showWithStatus:(NSString*)text;//加载视图、文字

+ (void)dismiss;


@end
