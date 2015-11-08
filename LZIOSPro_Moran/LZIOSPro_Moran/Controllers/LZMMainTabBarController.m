//
//  LZMMainTabBarController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMMainTabBarController.h"
#import "MBProgressHUD.h"
#import "LZMPublishViewController.h"
#import "LZMViewDetailController.h"
@interface LZMMainTabBarController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *pickController;
@end

@implementation LZMMainTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addview:) name:@"publishNotification" object:nil];
    
}

- (void)addview:(NSNotification *)noti{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera", @"photo", nil];
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
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
     __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"LZMPublish" bundle:[NSBundle mainBundle]];
        LZMPublishViewController *pVC = [SB instantiateViewControllerWithIdentifier:@"publishStoryboard"];
        pVC.imagePhoto = image;
        
        UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:pVC];
        [weakSelf presentViewController:nVC animated:YES completion:nil];
    }];
}


- (UIImagePickerController *)pickController{
    if (!_pickController) {
        _pickController = [[UIImagePickerController alloc] init];
        _pickController.delegate = self;
    }
    return _pickController;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
