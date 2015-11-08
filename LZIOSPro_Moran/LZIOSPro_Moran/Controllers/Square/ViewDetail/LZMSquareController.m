//
//  LZMViewDetailController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMSquareController.h"
#import "LZMGlobal.h"
#import "LZMSquareRequest.h"
#import "MBProgressHUD.h"
#import "LZMSquareCell.h"
#import "LZMSquareModel.h"
#import <CoreLocation/CoreLocation.h>
#import "KxMenu.h"
#import "MJRefresh.h"
@interface LZMSquareController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) LZMSquareRequest *squareRequest;
@property (nonatomic, strong) NSArray *addrArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) NSMutableDictionary *locationDic;
@end

@implementation LZMSquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame = CGRectMake(0, 0, 200, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    self.navigationItem.titleView = self.titleButton;
   
    self.tableview.rowHeight = 182;
    
    [self requestAllData];
    
    
    self.locationDic = [NSMutableDictionary dictionary];
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = 1000;
    
    CLAuthorizationStatus status =  [CLLocationManager authorizationStatus] ;
    if (status == kCLAuthorizationStatusNotDetermined) {
        
        if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
            [self.manager requestWhenInUseAuthorization];
        }
    }else if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted){
        [self showError:@"请允许访问位置"];
    }else{
        [self.manager startUpdatingLocation];
    }
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestAllData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableview.header endRefreshing];
            [self.tableview reloadData];
        });
    }];
    self.tableview.header.automaticallyChangeAlpha = YES;
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableview.footer endRefreshing];
        });
    }];

}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = [locations lastObject];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    [self.locationDic setValue:latitude forKey:@"latitude"];
    [self.locationDic setValue:longitude forKey:@"longitude"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            [self showError:@"location failed!"];
        }else{
            
            CLPlacemark *placeItem = [placemarks firstObject];
            NSArray *keys = [placeItem.addressDictionary allKeys];
            for (NSString *key in keys) {
                NSLog(@"%@ - %@", key, placeItem.addressDictionary[key]);
            }
            NSLog(@"formatAddress: %@", [placeItem.addressDictionary[@"FormattedAddressLines"] firstObject]);
            [self.locationDic setValue:[placeItem.addressDictionary[@"FormattedAddressLines"] firstObject] forKey:@"location"];
        }
        
    }];
    
    
    
    [self.manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.manager startUpdatingLocation];
}


- (void)titleButtonClick:(UIButton *)button{
    
    NSArray *menuItems = @[
                           [KxMenuItem menuItem:@"All" image:nil target:self action:@selector(requestAllData)],
                           [KxMenuItem menuItem:@"500m" image:nil target:self action:@selector(request500Data)],
                           [KxMenuItem menuItem:@"1000m" image:nil target:self action:@selector(request1000Data)],
                           [KxMenuItem menuItem:@"1500m" image:nil target:self action:@selector(request1500Data)]
                           ];
    UIView *superView = button.superview;
    CGRect editFrame = button.frame;
    CGRect rect = [superView convertRect:editFrame toView:[UIApplication sharedApplication].keyWindow];
    
    [KxMenu showMenuInView:[UIApplication sharedApplication].keyWindow fromRect:rect menuItems:menuItems];
    
}

- (void)request500Data{
    
}

- (void)request1000Data{
    
}

- (void)request1500Data{
    
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


- (void)showDetailImage{
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"LZMViewDetail" bundle:[NSBundle mainBundle]];
    LZMViewDetailController *detailVC = [SB instantiateViewControllerWithIdentifier:@"detailViewStoyboard"];
    detailVC.pictureModel = self.pictureModel;
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
