//
//  LZMRegisterRequestParser.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMUserModel.h"
@interface LZMRegisterRequestParser : NSObject
- (LZMUserModel *)parseJson:(NSData *)jsonData;
@end
