//
//  AppDelegate.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZMMyViewController.h"
#import "LZMLoginViewControllers.h"
#import "LZMSquareController.h"
#import "LZMMainTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) LZMLoginViewControllers *loginVC;
@property (nonatomic, strong) LZMMainTabBarController *tabBarVC;
@property (nonatomic, strong) LZMSquareController *squareVC;
- (void)loadLoginAndRegiesterViewController;
- (void)loadMainViewWithController:(UIViewController*)controlle;
@end

