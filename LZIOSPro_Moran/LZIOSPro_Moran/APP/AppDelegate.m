//
//  AppDelegate.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (void)loadLoginAndRegiesterViewController{
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"LZMLoginAndRegister" bundle:[NSBundle mainBundle]];
    
    self.loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.loginVC;
}

- (void)loadMainViewWithController:(UIViewController*)controller{
    
   // UIViewController *vc = [[UIViewController alloc] init];
    UIStoryboard *vcSB = [UIStoryboard storyboardWithName:@"LZMSquare" bundle:[NSBundle mainBundle]];
    LZMSquareController *vc = [vcSB instantiateViewControllerWithIdentifier:@"squareStoryboard"];
    self.squareVC = vc;
    
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230 / 255.0 green:106/255.0 blue:58/255.0 alpha:1];
    
    //nvc.tabBarItem.image = [UIImage imageNamed:@"square"];
    
    //UIImage *squareImage = [UIImage imageNamed:@"square_selected"];
    //squareImage = [squareImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //nvc.tabBarItem.selectedImage = squareImage;
    //nvc.tabBarItem.title = @"广场";
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"LZMMy" bundle:[NSBundle mainBundle]];
    
    UINavigationController *myNVC = [SB instantiateViewControllerWithIdentifier:@"MyNav"];
    
    
    myNVC.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    //myNVC.tabBarItem.title = @"我的";
    
    //UIImage *imageSelected = [UIImage imageNamed:@"my_selected"];
    //imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //myNVC.tabBarItem.selectedImage = imageSelected;
    //myNVC.tabBarItem.image = [UIImage imageNamed:@"my"];

    
    self.tabBarVC = [[LZMMainTabBarController alloc] init];
    
   
    
    self.tabBarVC.tabBarItemsAttributes = @[
                                            @{
                                                CYLTabBarItemTitle :@"广场",
                                                CYLTabBarItemImage :@"square",
                                                CYLTabBarItemSelectedImage:@"square_selected"
                                                },
                                            
                                            @{
                                                
                                                CYLTabBarItemTitle :@"我的",
                                                CYLTabBarItemImage :@"my",
                                                CYLTabBarItemSelectedImage:@"my_selected"

                                                }
                                            
                                            ];
    
     self.tabBarVC.viewControllers = @[nvc, myNVC];
    
    //self.window.rootViewController = self.tabBarVC;
    [controller presentViewController:self.tabBarVC animated:YES completion:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.loginVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.loginVC = nil;
    }];
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.window makeKeyAndVisible];
    [self loadLoginAndRegiesterViewController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
