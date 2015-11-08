//
//  LZMPublishParser.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMPublishParser.h"

@implementation LZMPublishParser

- (LZMPublishModel *)parsejson:(NSData *)data{
    
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"jsonserialize fail");
    }else{
        if ([jsonDic isKindOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"data"];
            id returnPic = [returnMessage valueForKey:@"pic_id"];
            if ([returnPic isKindOfClass:[NSString class]]) {
                LZMPublishModel *user = [[LZMPublishModel alloc] init];
                user.picId = returnPic;
                return user;
            }
        }
    }
    
    return nil;
}

@end
