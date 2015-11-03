//
//  LZMLoginRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMLoginRequest.h"
#import "BLMultipartForm.h"
#import "LZMLoginRequestParser.h"
@interface LZMLoginRequest ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *loginTask;

@end
@implementation LZMLoginRequest

- (void)loginRequestWithEmail:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid completionHandler:(loginCompletionHandler)handle{
    
    /*
    [self.loginTask cancel];
    self.session = nil;
    self.loginTask = nil;
    */
    NSURLSession *session = [NSURLSession sharedSession];
    self.session = session;
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/user/login";
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *loginURL = [NSURL URLWithString:url];
    
    NSMutableURLRequest *loginRequest = [[NSMutableURLRequest alloc] initWithURL:loginURL];
    loginRequest.HTTPMethod = @"POST";
    loginRequest.timeoutInterval = 60;
    loginRequest.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    
    [form addValue:email  forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    loginRequest.HTTPBody = [form httpBody];
    
    [loginRequest setValue:[form contentType] forHTTPHeaderField:@"Content-Type"];
    
     __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *loginTask = [session dataTaskWithRequest:loginRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        self.error = error;
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            LZMLoginRequestParser *parser = [[LZMLoginRequestParser alloc] init];
            weakSelf.user = [parser parseJson:data];
        }
        
        handle(weakSelf);
        
        
    }];
    
    self.loginTask = loginTask;
    
    [self.loginTask resume];
}
@end
