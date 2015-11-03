//
//  LZMRegisterViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMRegisterViewController.h"
#import "MBProgressHUD.h"
#import "LZMRegisterRequest.h"
@interface LZMRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *repeatpasswordTextfield;

@property (nonatomic, strong) LZMRegisterRequest *registerRequest;

@end


@implementation LZMRegisterViewController


-(void)viewDidLoad{
    
    self.usernameTextfield.text = @"comst";
    self.emailTextfield.text = @"750145240@qq.com";
    self.passwordTextfield.text = @"12345678";
    self.repeatpasswordTextfield.text = @"12345678";
}

- (IBAction)registerButtonClick:(UIButton *)sender {
    NSString *username = self.usernameTextfield.text;
    NSString *email = self.emailTextfield.text;
    NSString *password = self.passwordTextfield.text;
    NSString *repeatpwd = self.repeatpasswordTextfield.text;
    
    if ( [username length] == 0 || [email length] == 0 || [password length] == 0 || [repeatpwd length] == 0) {
        [self showError:@" no empty"];
    }else if([self isValidateEmail:email] == NO){
        [self showError:@"email invalidate"];
    }else if ([self isValidatePassword:password] == NO)
    {
        [self showError:@"password length must 6 - 20"];
    }else if (![password isEqualToString:repeatpwd]){
        [self showError:@"password not same"];
    }else{
        [self handleRegiste];
    }
    
}

- (LZMRegisterRequest *)registerRequest{
    if (!_registerRequest) {
        _registerRequest = [[LZMRegisterRequest alloc] init];
    }
    return _registerRequest;
}

- (void)handleRegiste{
    
    NSString *username = self.usernameTextfield.text;
    NSString *email = self.emailTextfield.text;
    NSString *password = self.passwordTextfield.text;
    
    NSString *gbid = @"G2015020223";
    
    [self.registerRequest registerRequestWithUserName:username email:email password:password gbid:gbid completionHandler:^(LZMRegisterRequest *request) {
      
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (request.error) {
                [self showError:@"register error"];
            }else{
                [self showError:request.user.registerReturnMessage];
            }
            
        });
    }];
    
}


- (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isValidatePassword:(NSString *)password{
    
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    
    return [passwordPredicate evaluateWithObject:password];
    return NO;
}

#pragma mark - loginbuttonclick
- (IBAction)loginButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - uitextfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (!CGAffineTransformIsIdentity(self.view.transform)) {
        
        return;
    }
    
    CGFloat registerButtonY = CGRectGetMaxY(self.registerButton.frame);
    
    CGFloat offset = registerButtonY - (self.view.frame.size.height - 216);
    
    if (offset > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -offset);
        }];
    }
    
}

#pragma mark touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    [self.view endEditing:YES];
}
@end
