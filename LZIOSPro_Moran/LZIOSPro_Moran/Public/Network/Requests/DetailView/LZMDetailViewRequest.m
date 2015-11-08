//
//  LZMDetailViewRequest.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMDetailViewRequest.h"
#import "LZMCommentModel.h"
@interface LZMDetailViewRequest ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *detailViewTask;
@end
@implementation LZMDetailViewRequest
- (void)detailViewRequestWithArgDic:(NSDictionary *)argdic completionHandler:(detailViewCompletionHandler)handler{
    self.session = nil;
    [self.detailViewTask cancel];
    self.detailViewTask = nil;
    
    
    self.session = [NSURLSession sharedSession];
    
    NSString *url = @"http://moran.chinacloudapp.cn/moran/web/comment";
    url = [NSString stringWithFormat:@"%@?user_id=%@&token=%@&pic_id=%@",url ,argdic[@"user_id"], argdic[@"token"], argdic[@"pic_id"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:url];
    
     __weak typeof(self) weakSelf = self;
    self.detailViewTask = [self.session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = jsonDic[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            for (NSDictionary *dic  in array) {
                LZMCommentModel *comment = [[LZMCommentModel alloc] init];
                [comment setValuesForKeysWithDictionary:dic];
                [arrayM addObject:comment];
            }
            weakSelf.commentsArr = arrayM;
        }
        handler(weakSelf);
    }];
    
    [self.detailViewTask resume];
    
}
@end
