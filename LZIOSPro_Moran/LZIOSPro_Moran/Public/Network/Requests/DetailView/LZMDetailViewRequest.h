//
//  LZMDetailViewRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LZMDetailViewRequest;

typedef void (^detailViewCompletionHandler)(LZMDetailViewRequest *request);

@interface LZMDetailViewRequest : NSObject
@property (nonatomic, strong) NSArray *commentsArr;
- (void)detailViewRequestWithArgDic:(NSDictionary *)argdic completionHandler:(detailViewCompletionHandler)handler;
@end
