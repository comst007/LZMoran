//
//  LZMSquareRequestParser.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMSquareRequestParser.h"

@implementation LZMSquareRequestParser
- (NSDictionary *)parseJson:(NSData *)data{
    
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *dictionaryM = [NSMutableDictionary dictionary];
    
    if (error) {
        NSLog(@"parser fial");
        return nil;
    }else{
        if ([jsonDic isKindOfClass:[NSDictionary class]]) {
            id data = [[jsonDic valueForKey:@"data"] allValues];
            for (id dic  in data) {
                self.addrArray = [NSMutableArray array];
                self.pictureArray = [NSMutableArray array];
                LZMSquareModel *squareModel = [[LZMSquareModel alloc] init];
                [squareModel setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDic in dic[@"pic"]) {
                    LZMPictureModel *pictureModel = [[LZMPictureModel alloc] init];
                    [pictureModel setValuesForKeysWithDictionary:picDic];
                    [self.pictureArray addObject:pictureModel];
                    
                }
                [self.addrArray addObject:squareModel];
                
                [dictionaryM setObject:self.pictureArray forKey:self.addrArray];
            }
            
        }
    }
    
    return dictionaryM;
}
@end
