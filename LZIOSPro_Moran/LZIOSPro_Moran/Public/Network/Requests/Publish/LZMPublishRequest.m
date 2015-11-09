//
//  LZMPublishRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMPublishRequest.h"
#import "BLMultipartForm.h"

@interface LZMPublishRequest ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *publishTask;

@end

@implementation LZMPublishRequest

- (void)publishRequestWithUserId:(NSString *)userid token:(NSString *)token longitude:(NSString *)longitude latitude:(NSString *)latitude title:(NSString *)title data:(NSData *)data location:(NSString *)location completionHandler:(publishRequestCompletionHandler)handler{
    
    
    self.session = nil;
    [self.publishTask cancel];
    self.publishTask = nil;
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/picture/create";
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:url];
    
    NSMutableURLRequest *publishRequest = [[NSMutableURLRequest alloc] initWithURL:URL];
    publishRequest.HTTPMethod = @"POST";
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:userid forField:@"user_id"];
    [form addValue:token forField:@"token"];
    [form addValue:data forField:@"data"];
    [form addValue:title forField:@"title"];
    [form addValue:location forField:@"location"];
    [form addValue:longitude forField:@"longitude"];
    [form addValue:latitude forField:@"latitude"];
    [form addValue:location forField:@"addr"];
    publishRequest.HTTPBody = [form httpBody];
    
    [publishRequest setValue:[form contentType] forHTTPHeaderField:@"Content-Type"];
     __weak typeof(self) weakSelf = self;
    self.publishTask = [self.session dataTaskWithRequest:publishRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        weakSelf.error = error;
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            LZMPublishParser *parser = [[LZMPublishParser alloc] init];
            weakSelf.publishModel = [parser parsejson:data];
           
        }
         handler(weakSelf);
    }];
    
    [self.publishTask resume];
}

- (NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sharedSession] ;
    }
    return _session;
}
@end
