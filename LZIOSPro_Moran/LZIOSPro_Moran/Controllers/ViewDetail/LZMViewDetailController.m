//
//  LZMViewDetailController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMViewDetailController.h"
#import "LZMUserModel.h"
#import "LZMGlobal.h"
#import "LZMDetailViewRequest.h"

@interface LZMViewDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *photoImageview;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) LZMDetailViewRequest *detailViewRequest;
@property (nonatomic, strong) NSArray *arrayOfComments;
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation LZMViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"照片详情";
    
    [self loadComments];
}


- (void)setPictureModel:(LZMPictureModel *)pictureModel{
    _pictureModel = pictureModel;
    [self.activity startAnimating];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pictureModel.pic_link]]];
    [self.activity stopAnimating];
    self.photoImageview.image = image;
}

- (UIActivityIndicatorView *)activity{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _activity.hidesWhenStopped = YES;
        _activity.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, 100);
        [self.view addSubview:_activity];
    }
    return _activity;
}


- (LZMDetailViewRequest *)detailViewRequest{
    if (!_detailViewRequest) {
        _detailViewRequest = [[LZMDetailViewRequest alloc] init];
    }
    return _detailViewRequest;
}

- (void)loadComments{
    
    LZMUserModel *user = [LZMGlobal sharedglobal].user;
    
    NSDictionary *requestArg = @{@"user_id": user.userId, @"token":user.token, @"pic_id" :self.pictureModel.pic_id};
    
     __weak typeof(self) weakSelf = self;
    [self.detailViewRequest detailViewRequestWithArgDic:requestArg completionHandler:^(LZMDetailViewRequest *request) {
        weakSelf.arrayOfComments = request.commentsArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.photoImageview.frame.size.height + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
            weakSelf.tableview.delegate = self;
            weakSelf.tableview.dataSource = self;
            weakSelf.tableview.rowHeight = 60;
            weakSelf.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            [weakSelf.tableview registerClass:[LZMCommenCell class] forCellReuseIdentifier:@"LZMComment"];
            [weakSelf.view addSubview:weakSelf.tableview];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfComments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZMCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZMComment"];
    
    LZMCommentModel *commentModel = self.arrayOfComments[indexPath.row];
    cell.comment = commentModel;
    
    return cell;
}
@end
