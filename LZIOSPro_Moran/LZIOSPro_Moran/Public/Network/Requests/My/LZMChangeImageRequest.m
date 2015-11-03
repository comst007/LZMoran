//
//  LZMChangeImageRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMChangeImageRequest.h"
#import "LZMGlobal.h"
#import "BLMultipartForm.h"
@interface LZMChangeImageRequest ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *headimageTask;
@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;

@end
@implementation LZMChangeImageRequest

- (void)headImageRequestWithImage:(UIImage *)image completionHandler:(changeHeadImageCompletionHandler)handle{
    [self.headimageTask cancel];
    self.session = nil;
    self.headimageTask = nil;
    
    
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/user/avatar";
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:url];
    
    NSMutableURLRequest *headImageRequest = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    
    headImageRequest.HTTPMethod = @"POST";
    
    [form addValue:[LZMGlobal sharedglobal].user.userId forField:@"user_id"];
    [form addValue:[LZMGlobal sharedglobal].user.token forField:@"token"];
    
    
   
    
   
    NSData *imageData = UIImageJPEGRepresentation(image, 0.00001);
  
    
   
    
    [form addValue:imageData forField:@"data"];
    NSLog(@"uploadlen: %li", [imageData length]);
    
    //headImageRequest.HTTPBody = [form httpBody];
    [headImageRequest setValue:[form contentType] forHTTPHeaderField:@"Content-Type"];
    
    headImageRequest.timeoutInterval = 60;
    headImageRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    self.session = [NSURLSession sharedSession];
     __weak typeof(self) weakSelf = self;
    self.uploadTask = [self.session uploadTaskWithRequest:headImageRequest fromData:[form httpBody] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        weakSelf.error = error;
        
        
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            weakSelf.returnMsg = dic[@"message"];
        }
        handle(weakSelf);

        
    }];
    
    /*
     __weak typeof(self) weakSelf = self;
    self.headimageTask = [self.session dataTaskWithRequest:headImageRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        weakSelf.error = error;
        
        
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            weakSelf.returnMsg = dic[@"message"];
        }
        handle(weakSelf);
    }];
    
    [self.headimageTask resume];
    */
    [self.uploadTask resume];
}

@end

