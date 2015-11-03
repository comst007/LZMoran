//
//  LZMUserModel.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZMUserModel : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *loginReturnMessage;
@property (nonatomic, copy) NSString *registerReturnMessage;
@end
