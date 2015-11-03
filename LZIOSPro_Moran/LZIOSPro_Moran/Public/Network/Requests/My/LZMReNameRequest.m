//
//  LZMReNameRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMReNameRequest.h"
#import "BLMultipartForm.h"
#import "LZMGlobal.h"
@interface LZMReNameRequest ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *renameTask;

@end
@implementation LZMReNameRequest

- (void)renameRequestWithNewName:(NSString *)newname completionHandler:(renameCompletionHandler)handle{
    
    
    [self.renameTask cancel];
    self.session = nil;
    self.renameTask = nil;
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/user/rename";
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *renameURL = [NSURL URLWithString:url];
    
    self.session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *renameRequest = [[NSMutableURLRequest alloc] initWithURL:renameURL];
    renameRequest.HTTPMethod = @"POST";
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:[LZMGlobal sharedglobal].user.userId forField:@"user_id"];
    [form addValue:[LZMGlobal sharedglobal].user.token forField:@"token"];
    [form addValue:newname forField:@"new_name"];
    renameRequest.HTTPBody = [form httpBody];
    
    [renameRequest setValue:[form contentType] forHTTPHeaderField:@"Content-Type"];
    
    
     __weak typeof(self) weakSelf = self;
    self.renameTask = [self.session dataTaskWithRequest:renameRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        weakSelf.error = error;
        
        if (error == nil && [(NSHTTPURLResponse *)response statusCode] == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            weakSelf.returnMsg = dic[@"message"];
        }
        handle(weakSelf);
    }];
    
    [self.renameTask resume];
    
    
}
@end
