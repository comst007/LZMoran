//
//  LZMLocationParser.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMLocationParser.h"
#import "LZMLocationModel.h"

@implementation LZMLocationParser
-(NSArray *)parseJsonData:(NSData *)data{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *addrList = jsonDic[@"addrList"];
    if (addrList == nil || addrList.count == 0) {
        return nil;
    }
    for (NSDictionary *dic  in addrList) {
        if ([dic[@"status"] intValue] == 1) {
            LZMLocationModel *locationModel = [[LZMLocationModel alloc] init];
            locationModel.Locationame = [dic[@"name"] length] > 0 ? dic[@"name"]:@"无法精确定位";
            locationModel.admName = [dic[@"admName"] length] > 0 ? dic[@"admName"] :@"无法获取精确位置";
            [arrayM addObject:locationModel];
        }
    }
    return arrayM;
}
@end
