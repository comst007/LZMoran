//
//  LZMMyViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMMyViewController.h"
#import "LZMGlobal.h"
#import "AppDelegate.h"
@interface LZMMyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;


@end
@implementation LZMMyViewController


- (void)viewDidLoad{
    
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20]};
    
    self.headImage.image = [LZMGlobal sharedglobal].user.image ?  [LZMGlobal sharedglobal].user.image : [UIImage imageNamed:@"bkground"];
    self.usernameLabel.text = [LZMGlobal sharedglobal].user.username;
    self.emailLabel.text = [LZMGlobal sharedglobal].user.email;
    
    //self.view.translatesAutoresizingMaskIntoConstraints
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.headImage.image = [LZMGlobal sharedglobal].user.image ?  [LZMGlobal sharedglobal].user.image : [UIImage imageNamed:@"bkground"];
    self.usernameLabel.text = [LZMGlobal sharedglobal].user.username;
    self.emailLabel.text = [LZMGlobal sharedglobal].user.email;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 13;
    }
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2 && indexPath.section == 0) {
        
        AppDelegate *appdl = [UIApplication sharedApplication].delegate;
        [self dismissViewControllerAnimated:YES completion:nil];
        [LZMGlobal sharedglobal].user = nil;
        [appdl loadLoginAndRegiesterViewController];
    }
}
@end
