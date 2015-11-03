//
//  LZMRegisterRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMRegisterRequest.h"
#import "BLMultipartForm.h"
#import "LZMRegisterRequestParser.h"
@interface LZMRegisterRequest ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *registertask;
@end
@implementation LZMRegisterRequest


- (void)registerRequestWithUserName:(NSString *)username email:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid completionHandler:(registerCompletionHandler)handle{
    
    [self.registertask cancel];
    self.session = nil;
    self.registertask = nil;
    
    self.session = [NSURLSession sharedSession];
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/user/register";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *registerURL = [NSURL URLWithString:url];
    
    NSMutableURLRequest *registerRequest = [[NSMutableURLRequest alloc] initWithURL:registerURL];
    registerRequest.HTTPMethod = @"POST";
    registerRequest.timeoutInterval = 60;
    registerRequest.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:username forField:@"username"];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    
    registerRequest.HTTPBody = [form httpBody];
    [registerRequest setValue:[form contentType] forHTTPHeaderField:@"Content-Type"];
    
    
    
     __weak typeof(self) weakSelf = self;
    self.registertask = [self.session dataTaskWithRequest:registerRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        weakSelf.error = error;
        NSLog(@"response: %@", response);
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            LZMRegisterRequestParser *parser = [[LZMRegisterRequestParser alloc] init];
            self.user = [parser parseJson:data];
           
        }
        handle(weakSelf);
    }];
    
    [self.registertask resume];
}
@end
