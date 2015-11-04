//
//  LZMSquareRequestParser.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZMSquareModel.h"
#import "LZMPictureModel.h"
@interface LZMSquareRequestParser : NSObject
@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSMutableArray *pictureArray;

- (NSDictionary *)parseJson:(NSData*)data;

@end
