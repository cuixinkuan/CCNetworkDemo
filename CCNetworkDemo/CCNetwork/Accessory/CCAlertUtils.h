//
//  CCAlertUtils.h
//  CCNetworkDemo
//
//  Created by admin on 2018/1/15.
//  Copyright © 2018年 cuixinkuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRequest.h"

@interface CCAlertUtils : UIView

@property (nonatomic,weak)UIView * animatingView;
@property (nonatomic,strong)NSString * animatingText;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)id request;

+ (instancetype)shared;
+ (void)showLoadingAlertView:(NSString *)animatingText inView:(UIView *)animatingView withRequest:(id)request;
+ (void)hideLoadingView;

@end
