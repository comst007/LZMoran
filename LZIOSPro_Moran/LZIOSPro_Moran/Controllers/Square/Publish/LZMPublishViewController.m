//
//  LZMPublishViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMPublishViewController.h"

@interface LZMPublishViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageview;
@property (weak, nonatomic) IBOutlet UITextView *wordsTextview;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation LZMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoImageview.image = self.imagePhoto;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
