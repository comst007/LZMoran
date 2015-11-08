//
//  LZMPublishRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMPublishParser.h"
@class LZMPublishRequest;

typedef void (^publishRequestCompletionHandler)(LZMPublishRequest *request);

@interface LZMPublishRequest : NSObject
@property (nonatomic, strong) LZMPublishModel *publishModel;
@property (nonatomic, strong) NSError *error;
- (void)publishRequestWithUserId:(NSString *)userid
                           token:(NSString *)token
                       longitude:(NSString *)longitude
                        latitude:(NSString *)latitude
                           title:(NSString *)title
                            data:(NSData *)data
                        location:(NSString *)location
               completionHandler:(publishRequestCompletionHandler)handler;

@end
