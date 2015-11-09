//
//  LZMPublishViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

/**
 *  apiKey
 *
 *  @value      n2KUEHP87GGDqAGOoqAyxHRE
 *
 *api.map.baidu.com/geocoder/v2/?ak=n2KUEHP87GGDqAGOoqAyxHRE&location=39.983424,116.322987&output=json&pois=1
 *
 
 
 apikey:  66a090e464948fd6aea03f1839e2b78f
 */
#define selfWidth   self.view.frame.size.width
#define selfHeight  self.view.frame.size.height
#define APIKey @"66a090e464948fd6aea03f1839e2b78f"

#import "LZMPublishViewController.h"
#import "LZMPublishCell.h"
#import "LZMPublishRequest.h"
#import "LZMGlobal.h"
#import "LZMUserModel.h"
#import "MBProgressHUD.h"
#import "LZMLocationParser.h"
#import "LZMLocationModel.h"
#import <CoreLocation/CoreLocation.h>
@interface LZMPublishViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImageview;
@property (weak, nonatomic) IBOutlet UITextView *wordsTextview;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic, weak) IBOutlet UIButton *locationButton;

@property (nonatomic, strong) UITableView *locationsTableview;
@property (nonatomic, strong) UIControl *blackview;

@property (nonatomic, assign) BOOL openOrNot;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) LZMPublishRequest *publishRequest;

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) NSMutableDictionary *locationDic;
@property (nonatomic, copy) NSArray *arrayOfLocation;
@end

@implementation LZMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadframeChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    // Do any additional setup after loading the view.
    self.photoImageview.image = self.imagePhoto;
    
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230 / 255.0 green:106 / 255.0 blue:58 / 255.0 alpha:1];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布照片";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishButtonClick:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(bacButtonClick)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
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
            
            [self.locationButton setTitle:[placeItem.addressDictionary[@"FormattedAddressLines"] firstObject] forState:UIControlStateNormal];
        }
        
    }];
    
    
    
    [self.manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.manager startUpdatingLocation];
}


- (void)bacButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)validateText:(NSString *)text{
    
    NSString *str1 = [text stringByReplacingOccurrencesOfString:@" "  withString:@""];
    if ([str1 length] == 0) {
        return NO;
    }
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if ([str2 length] == 0) {
        return NO;
    }
    
    NSString *str3 = [text stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if ([str3 length] == 0) {
        return NO;
    }
    return YES;
}

- (void)publishButtonClick:(UIBarButtonItem *)btn{
    
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    if ([self.wordsTextview.text isEqualToString:@"你想说的话"]) {
        [self showError:@"请写上你的留言"];
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        return;
    }
    if ([self.wordsTextview.text length] > 25 || [self.wordsTextview.text length] == 0) {
        [self showError:@"字数不能超过25也不能为空！"];
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        return ;
    }
    
    if ([self validateText:self.wordsTextview.text] == NO) {
        
        [self showError:@"输入有效字符"];
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        return ;
    }
    if ([self.activity isAnimating]) {
        [self.activity stopAnimating];
    }
    
    [self.activity startAnimating];
    
    LZMUserModel *user = [LZMGlobal sharedglobal].user;
    
    NSData *imageData = UIImageJPEGRepresentation(self.imagePhoto, 0.00001);
     __weak typeof(self) weakSelf = self;
    
    [self.publishRequest publishRequestWithUserId:user.userId token:user.token longitude:@"121.47794" latitude:@"31.22516" title:self.wordsTextview.text data:imageData location:self.locationButton.titleLabel.text completionHandler:^(LZMPublishRequest *request) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.activity stopAnimating];
            weakSelf.navigationController.navigationBar.userInteractionEnabled = YES;
            if (request.error) {
                [weakSelf showError:@"publish fail"];
            }else{
                [weakSelf bacButtonClick];
            }
        });
    }];
    
    
    
}

- (LZMPublishRequest *)publishRequest{
    if (!_publishRequest) {
        _publishRequest = [[LZMPublishRequest alloc] init];
    }
    return _publishRequest;
}

- (IBAction)relocation{
    
    [self showOrHideTableview];
    [self makeLocation];
    
    
}

- (void)makeLocation{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        NSString *latitude = [NSString stringWithFormat:@"l=%@", [self.locationDic valueForKey:@"latitude"]];
        NSString *string1 = [latitude stringByAppendingString:@"%2C"];
        NSString *httpArg = [NSString stringWithFormat:@"%@%@", string1, [self.locationDic valueForKey:@"longitude"]];
        
        NSString *httpURL = @"http://apis.baidu.com/3023/geo/address";
        [self request:httpURL arg:httpArg];
    }];
}

- (void)request:(NSString *)httpURL arg:(NSString *)httpArg{
    NSString *URLstr = [NSString stringWithFormat:@"%@?%@", httpURL, httpArg];

    NSURL *URL = [NSURL URLWithString:URLstr];
    
    NSMutableURLRequest *requestM = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    requestM.HTTPMethod = @"GET";
    
    [requestM setValue:APIKey forHTTPHeaderField:@"apikey"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *locationTask = [session dataTaskWithRequest:requestM completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            [self showError:@"获取位置列表失败"];
        }else{
            LZMLocationParser *parser = [[LZMLocationParser alloc] init];
            self.arrayOfLocation = [parser parseJsonData:data];
            [self.locationsTableview reloadData];
        }
        
        
    }];
    
    [locationTask resume];
}

- (IBAction)relocadPhoto{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"publishNotification" object:nil];
    }];
}


- (void)showOrHideTableview{
    if (self.openOrNot == NO) {
        self.openOrNot = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.blackview.alpha = 0.7;
                             self.locationsTableview.transform = CGAffineTransformTranslate(self.locationsTableview.transform, 0, -230);
                         }];
        
    }else{
        self.openOrNot = NO;
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             self.blackview.alpha = 0;
                             self.locationsTableview.transform = CGAffineTransformIdentity;
                         }];
        
    }
    
}

- (UITableView *)locationsTableview{
    if (!_locationsTableview) {
        NSLog(@"tableview");
        _locationsTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth , 230) style:UITableViewStylePlain];
        _locationsTableview.delegate = self;
        _locationsTableview.dataSource = self;
        [_locationsTableview registerNib:[UINib nibWithNibName:@"LZMPublishCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LZMPublishCell"];
        
        _locationsTableview.showsHorizontalScrollIndicator = NO;
        _locationsTableview.showsVerticalScrollIndicator = YES;
        _locationsTableview.separatorColor = [UIColor blackColor];
        _locationsTableview.backgroundColor = [UIColor whiteColor];
        _locationsTableview.rowHeight = 63;
        [self.view addSubview:_locationsTableview];
        
    }
    return _locationsTableview;
}

- (UIControl *)blackview{
    if (!_blackview) {
        _blackview = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight - 230)];
        _blackview.alpha = 0;
        _blackview.backgroundColor = [UIColor blackColor];
        [_blackview addTarget:self action:@selector(showOrHideTableview) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_blackview];
    }
    return _blackview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayOfLocation.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZMPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZMPublishCell"];
    LZMLocationModel *model = self.arrayOfLocation[indexPath.row];
    cell.nameLabel.text = model.Locationame;
    cell.placeLabel.text  = model.admName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZMLocationModel *model = self.arrayOfLocation[indexPath.row];
    
    [self.locationButton setTitle:model.Locationame forState:UIControlStateNormal];
    [self showOrHideTableview];
}

- (UIActivityIndicatorView *)activity{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.center = CGPointMake(selfWidth * 0.5, 160);
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _activity.hidesWhenStopped = YES;
        [self.view addSubview:_activity];
    }
    return _activity;
}
/**
 *  UIKeyboardAnimationCurveUserInfoKey = 7;
    UIKeyboardAnimationDurationUserInfoKey = "0.25";
    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
    UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
 *
 *  @param noti <#noti description#>
 */
- (void)keyboadframeChange:(NSNotification *)noti{
    
    NSDictionary *keyboardInfo = noti.userInfo;
    
    CGRect rectBegin = [(NSValue *)keyboardInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //CGRect rectEnd = [(NSValue *)keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardHeight = rectBegin.size.height;
    
    //keyboard show
    if (rectBegin.origin.y == [UIScreen mainScreen].bounds.size.height) {
        
        CGFloat maxY = CGRectGetMaxY(self.wordsTextview.frame);
        if (selfHeight - keyboardHeight < maxY) {
            [UIView animateWithDuration:0.5 animations:^{
                
                self.view.transform = CGAffineTransformTranslate(self.wordsTextview.transform, 0, selfHeight - keyboardHeight - maxY);
            }];
        }
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            
            self.view.transform = CGAffineTransformIdentity;
            
        }];
    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"textview: %@, range:%@, replace:%@", textView.text, NSStringFromRange(range), text);
    if ([textView.text length] >= 25) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >= 25) {
        [textView resignFirstResponder];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%i/25", (int)textView.text.length];
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

- (void)showError:(NSString *)msg{
    
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
    alert.mode = MBProgressHUDModeText;
    alert.minShowTime = 1.5;
    alert.labelText = msg;
    [self.view addSubview:alert];
    alert.removeFromSuperViewOnHide = YES;
    [alert show:YES];
    [alert hide:YES afterDelay:3];
    
}
@end
