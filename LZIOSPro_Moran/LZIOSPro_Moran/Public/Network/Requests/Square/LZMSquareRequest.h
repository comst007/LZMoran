//
//  LZMSquareRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMSquareRequestParser.h"
@class LZMSquareRequest;
typedef void (^squareRequestCompletionHandler)(LZMSquareRequest *request);


@interface LZMSquareRequest : NSObject
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *resDic;
- (void)squareRequestWithParameter:(NSDictionary *)paraDic
                 completionHandler:(squareRequestCompletionHandler)handle;
@end
