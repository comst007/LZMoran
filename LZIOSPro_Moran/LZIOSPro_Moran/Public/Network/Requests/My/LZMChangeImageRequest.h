//
//  LZMChangeImageRequest.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LZMChangeImageRequest;

typedef void (^changeHeadImageCompletionHandler)(LZMChangeImageRequest *request);

@interface LZMChangeImageRequest : NSObject

@property (nonatomic, copy) NSString *returnMsg;
@property (nonatomic, strong) NSError *error;
- (void)headImageRequestWithImage:(UIImage *)image completionHandler:(changeHeadImageCompletionHandler)handle;
@end
