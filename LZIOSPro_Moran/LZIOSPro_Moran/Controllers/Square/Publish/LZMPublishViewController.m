//
//  LZMPublishViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMPublishViewController.h"

@interface LZMPublishViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImageview;
@property (weak, nonatomic) IBOutlet UITextView *wordsTextview;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation LZMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoImageview.image = self.imagePhoto;
    
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230 / 255.0 green:106 / 255.0 blue:58 / 255.0 alpha:1];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布照片";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishButtonClick)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)publishButtonClick{
    
}


- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 25) {
        [textView resignFirstResponder];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/25", textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"你想说的话"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1) {
        textView.text = @"你想说的话";
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.wordsTextview endEditing:YES];
}
@end
