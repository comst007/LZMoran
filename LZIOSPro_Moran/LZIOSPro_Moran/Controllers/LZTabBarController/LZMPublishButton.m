//
//  LZMPublishButton.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMPublishButton.h"
#import "MBProgressHUD.h"

@interface LZMPublishButton ()
@end
@implementation LZMPublishButton

+ (void)load{
    
    [super registerSubclass];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    
    
    return self;
}

+ (instancetype)plusButton{
    
    LZMPublishButton *publishButton = [[LZMPublishButton alloc] init];
    
    [publishButton setTitle:@"publish" forState:UIControlStateNormal];
    [publishButton setTitle:@"publish" forState:UIControlStateHighlighted];
    publishButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [publishButton setImage:[UIImage imageNamed:@"pubilsh"] forState:UIControlStateNormal];
    [publishButton setImage:[UIImage imageNamed:@"pubilsh_hover"] forState:UIControlStateHighlighted];
    
    [publishButton addTarget:publishButton action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [publishButton sizeToFit];
    return publishButton;
}


- (void)publishBtnClick:(LZMPublishButton *)btn{
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"publishNotification" object:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotification:@"publishNotification"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"publishNotification" object:nil userInfo:nil];
}



- (void)showError:(NSString *)msg{
    
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    alert.mode = MBProgressHUDModeText;
    alert.minShowTime = 3;
    alert.labelText = msg;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    alert.removeFromSuperViewOnHide = YES;
    [alert show:YES];
    [alert hide:YES afterDelay:3];
    
}

+ (CGFloat)multiplerInCenterY{
    
    return 0.2;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);

}

@end
