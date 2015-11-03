//
//  LZMLoginViewControllers.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMLoginViewControllers.h"
#import "MBProgressHUD.h"
#import "LZMLoginRequest.h"
#import "LZMRegisterViewController.h"
#import "AppDelegate.h"
#import "LZMGlobal.h"
#import "LZMHeadimageRequest.h"
@interface LZMLoginViewControllers ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (nonatomic, strong) LZMLoginRequest *loginRequest;
@property (nonatomic, strong) LZMHeadimageRequest *headImageRequest;
@end

@implementation LZMLoginViewControllers

- (void)viewDidLoad{
   self.emailTextfield.text = @"750145240@qq.com";
    self.passwordTextfield.text = @"12345678";
    
}

#pragma mark register
- (IBAction)registerbuttonClick:(UIButton *)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"LZMLoginAndRegister" bundle:[NSBundle mainBundle]];
    
    LZMRegisterViewController *registerVC = [SB instantiateViewControllerWithIdentifier:@"RegisterStoryboard"];
    [self presentViewController:registerVC animated:YES completion:nil];
}



#pragma mark login
- (IBAction)loginButtonClick:(UIButton *)sender {
    
    if ([self.emailTextfield.text length] == 0 || [self.passwordTextfield.text length] == 0) {
        [self showError:@"username or password not empty!"];
        return ;
    }
    [self loginHandle];
    
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

- (void)loginHandle{
    
    NSString *email = self.emailTextfield.text;
    NSString *password = self.passwordTextfield.text;
    NSString *gbid = @"G2015020223";
    
    [self.loginRequest loginRequestWithEmail:email password:password gbid:gbid completionHandler:^(LZMLoginRequest *request) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (request.error) {
                [self showError:@"login error"];
            }else{
                [self showError:request.user.loginReturnMessage];
                if ([request.user.loginReturnMessage isEqualToString:@"Login success"]) {
                    
                    [LZMGlobal sharedglobal].user = request.user;
                    [LZMGlobal sharedglobal].user.email = self.emailTextfield.text;
                    
                    [self.headImageRequest headImageRequest];
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    
                    [appDelegate loadMainViewWithController:self];
                }
            }
        });
    }];
    
}

- (LZMHeadimageRequest *)headImageRequest{
    if (!_headImageRequest) {
        _headImageRequest = [[LZMHeadimageRequest alloc] init];
    }
    return _headImageRequest;
}

- (LZMLoginRequest *)loginRequest{
    if (!_loginRequest) {
        _loginRequest = [[LZMLoginRequest alloc] init];
    }
    return _loginRequest;
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

@end
