//
//  LZMNickNameViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMNickNameViewController.h"
#import "LZMReNameRequest.h"
#import "LZMGlobal.h"
#import "MBProgressHUD.h"
@interface LZMNickNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) LZMReNameRequest *renameRequest;
@end

@implementation LZMNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTextfield.text = [LZMGlobal sharedglobal].user.username;
    // Do any additional setup after loading the view.
}
- (IBAction)doneButtonClick:(UIBarButtonItem *)sender {
    
    [self.renameRequest renameRequestWithNewName:self.usernameTextfield.text completionHandler:^(LZMReNameRequest *request) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if (request.error) {
                [self showError:@"update error"];
            }else{
                [self showError:request.returnMsg];
                if ([request.returnMsg isEqualToString: @"Update success"]) {
                    [LZMGlobal sharedglobal].user.username = self.usernameTextfield.text;
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        });
    }];
    
}


- (void)showError:(NSString *)msg{
    
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
    alert.mode = MBProgressHUDModeText;
    alert.minShowTime = 3;
    alert.labelText = msg;
    [self.view addSubview:alert];
    alert.removeFromSuperViewOnHide = YES;
    [alert show:YES];
    [alert hide:YES afterDelay:3];
    
}

- (LZMReNameRequest *)renameRequest{
    
    if (!_renameRequest) {
        _renameRequest = [[LZMReNameRequest alloc] init];
    }
    return _renameRequest;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

@end
