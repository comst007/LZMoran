//
//  LZMViewDetailController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMViewDetailController.h"
#import "LZMGlobal.h"
#import "LZMSquareRequest.h"
#import "MBProgressHUD.h"
#import "LZMSquareCell.h"
#import "LZMSquareModel.h"
@interface LZMViewDetailController ()<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) LZMSquareRequest *squareRequest;
@property (nonatomic, strong) NSArray *addrArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIButton *titleButton;
@end

@implementation LZMViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame = CGRectMake(0, 0, 200, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    self.navigationItem.titleView = self.titleButton;
   
    self.tableview.rowHeight = 170;
    
    [self requestAllData];
}

- (void)titleButtonClick:(UIButton *)button{
    
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

- (void)requestAllData{
    
    NSDictionary *paraDict = @{@"distance":@"1000", @"latitude":@"31.22516", @"longitude":@"121.47794", @"token":[LZMGlobal sharedglobal].user.token, @"user_id":[LZMGlobal sharedglobal].user.userId};
    [self.squareRequest squareRequestWithParameter:paraDict completionHandler:^(LZMSquareRequest *request) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (request.error) {
                
                [self showError:@"request fail"];
                
            }else{
                
                self.addrArray = [[request resDic] allKeys];
                self.dataDic = [request resDic];
                
                [self.tableview reloadData];
            }
        });
        
        
    }];
    
}

- (LZMSquareRequest *)squareRequest{
    if (!_squareRequest) {
        _squareRequest = [[LZMSquareRequest alloc] init];
    }
    return _squareRequest;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addrArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZMSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squareCell"];
    LZMSquareModel *model = [self.addrArray[indexPath.row] lastObject];
    
    cell.locationLabel.text = model.addr;
    cell.dataArr = self.dataDic[self.addrArray[indexPath.row]];
    [cell.collectionView reloadData];
    return cell;
}


@end
