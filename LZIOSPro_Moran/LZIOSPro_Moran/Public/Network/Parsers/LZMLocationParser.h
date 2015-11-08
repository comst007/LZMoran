//
//  LZMLocationParser.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZMLocationParser : NSObject
- (NSArray *)parseJsonData:(NSData *)data;
@end
