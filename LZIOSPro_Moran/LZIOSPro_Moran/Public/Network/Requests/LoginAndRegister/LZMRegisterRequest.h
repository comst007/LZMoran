//
//  LZMRegisterRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMUserModel.h"
@class LZMRegisterRequest;
typedef void (^registerCompletionHandler)(LZMRegisterRequest *request);

@interface LZMRegisterRequest : NSObject

@property (nonatomic, strong)  LZMUserModel *user;
@property (nonatomic, strong) NSError *error;

- (void)registerRequestWithUserName:(NSString *)username
                           email:(NSString *)email
                        password:(NSString *)password
                            gbid:(NSString *)gbid
               completionHandler:(registerCompletionHandler)handle;


@end
