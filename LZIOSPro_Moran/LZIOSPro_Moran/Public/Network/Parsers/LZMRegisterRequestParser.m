//
//  LZMRegisterRequestParser.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMRegisterRequestParser.h"
@implementation LZMRegisterRequestParser

- (LZMUserModel *)parseJson:(NSData *)jsonData{
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"parse failed!");
    }else{
        if ([jsonDict isKindOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDict valueForKey:@"message"];
            
            if ([returnMessage isKindOfClass:[NSString class]]) {
                LZMUserModel *user = [[LZMUserModel alloc] init];
                user.registerReturnMessage = returnMessage;
                
                return user;
            }
        }
    }
    
    return nil;
}
@end
