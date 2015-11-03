//
//  LZMLoginRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMUserModel.h"
@class LZMLoginRequest;

typedef void (^loginCompletionHandler)(LZMLoginRequest *request);

@interface LZMLoginRequest : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) LZMUserModel *user;

- (void)loginRequestWithEmail:(NSString *)username password:(NSString *)password gbid:(NSString *)gbid completionHandler:(loginCompletionHandler)handle;

@end
