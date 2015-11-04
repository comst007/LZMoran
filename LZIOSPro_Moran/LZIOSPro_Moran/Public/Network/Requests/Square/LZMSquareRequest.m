//
//  LZMSquareRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMSquareRequest.h"


@interface LZMSquareRequest ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end
@implementation LZMSquareRequest

- (void)squareRequestWithParameter:(NSDictionary *)paraDic completionHandler:(squareRequestCompletionHandler)handle{
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/node/list";
    
    url = [NSString stringWithFormat:@"%@?distance=%@&latitude=%@&longitude=%@&token=%@&user_id=%@", url,paraDic[@"distance"], paraDic[@"latitude"], paraDic[@"longitude"], paraDic[@"token"], paraDic[@"user_id"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:url];
    
    self.session = [NSURLSession sharedSession];
    
     __weak typeof(self) weakSelf = self;
    self.dataTask = [self.session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        weakSelf.error = error;
        if (error ==nil &&[(NSHTTPURLResponse *)response statusCode] == 200) {
            
            LZMSquareRequestParser *parser = [[LZMSquareRequestParser alloc] init];
            weakSelf.resDic = [parser parseJson:data];
           
        }
         handle(weakSelf);
        
    }];
    
    [self.dataTask resume];
}





@end
