//
//  LZMHeadimageRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMHeadimageRequest.h"
#import "LZMGlobal.h"

@interface LZMHeadimageRequest ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *imageTask;

@end
@implementation LZMHeadimageRequest

- (void)headImageRequest{
    
    self.session = [NSURLSession sharedSession];
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    url = [url stringByAppendingFormat:@"?user_id=%@", [LZMGlobal sharedglobal].user.userId];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.imageTask = [self.session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            [LZMGlobal sharedglobal].user.image = [UIImage imageWithData:data];;
        }else{
            NSLog(@"fail to get head image, %@", response);
        }
    }];
    [self.imageTask resume];
}

@end
