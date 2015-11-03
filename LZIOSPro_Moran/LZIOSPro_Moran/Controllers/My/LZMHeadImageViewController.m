//
//  LZMHeadImageViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMHeadImageViewController.h"
#import "LZMChangeImageRequest.h"
#import "MBProgressHUD.h"
#import "LZMGlobal.h"
@interface LZMHeadImageViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headimageview;
@property (nonatomic, strong) LZMChangeImageRequest *headImageRequest;
@property (nonatomic, strong) UIImagePickerController *pickController;
@end

@implementation LZMHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)changeHeadImage:(UIBarButtonItem *)sender {
    [self.headImageRequest headImageRequestWithImage:self.headimageview.image completionHandler:^(LZMChangeImageRequest *request) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (request.error) {
                [self showError:@"upload failed"];
            }else{
                [self showError:request.returnMsg];
                if ([request.returnMsg isEqualToString:@"Update success"]) {
                    [LZMGlobal sharedglobal].user.image = self.headimageview.image;
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}


- (IBAction)selectHeadImage:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera", @"photo", nil];
    
    [sheet showInView:self.view];
}

- (LZMChangeImageRequest *)headImageRequest{
    if (!_headImageRequest) {
        _headImageRequest = [[LZMChangeImageRequest alloc] init];
    }
    return _headImageRequest;
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


- (UIImagePickerController *)pickController{
    if (!_pickController) {
        _pickController = [[UIImagePickerController alloc] init];
        _pickController.delegate = self;
    }
    return _pickController;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"camera"]) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showError:@"camera not use"];
        }else{
            self.pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.pickController animated:YES completion:nil];
        }
    }else if ([title isEqualToString:@"photo"]){
        self.pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.pickController animated:YES completion:nil];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.headimageview.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
