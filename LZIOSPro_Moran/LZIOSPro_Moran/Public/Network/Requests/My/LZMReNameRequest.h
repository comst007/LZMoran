//
//  LZMReNameRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LZMReNameRequest;

typedef void (^renameCompletionHandler)(LZMReNameRequest *request);


@interface LZMReNameRequest : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) NSString *returnMsg;
- (void)renameRequestWithNewName:(NSString *)newname completionHandler:(renameCompletionHandler)handle;

@end
