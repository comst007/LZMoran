//
//  LZMPublishParser.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMPublishModel.h"

@interface LZMPublishParser : NSObject

- (LZMPublishModel *)parsejson:(NSData *)data;
@end
