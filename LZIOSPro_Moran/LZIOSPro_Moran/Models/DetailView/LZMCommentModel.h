//
//  LZMCommentModel.h
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZMCommentModel : NSObject
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *modified;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
