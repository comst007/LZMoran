//
//  LZMLoginRequestParser.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMLoginRequestParser.h"

@implementation LZMLoginRequestParser

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
                user.loginReturnMessage = returnMessage;
                
                id dataDict = [jsonDict valueForKey:@"data"];
                
                if ([dataDict isKindOfClass:[NSDictionary class]]) {
                    id userid = [dataDict valueForKey:@"user_id"];
                    if ([userid isKindOfClass:[NSString class]]) {
                        user.userId = userid;
                    }
                    id token = [dataDict valueForKey:@"token"];
                    if ([token isKindOfClass:[NSString class]]) {
                        user.token = token;
                    }
                    id username = [dataDict valueForKey:@"user_name"];
                    if ([username isKindOfClass:[NSString class]]) {
                        user.username = username;
                    }
                    
                    
                }
                return user;
             }
        }
    }
    
    return nil;
}
@end
