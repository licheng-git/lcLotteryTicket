//
//  Tools_oc.m
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/1.
//  Copyright © 2017年 李诚. All rights reserved.
//

#import "Tools_oc.h"
#include <netdb.h>
#include <arpa/inet.h>

@implementation Tools_oc
    
    + (NSString *)getIP:(NSString *)remoteDomain {
        //NSString *remoteDomain = @"https://www.baidu.com";  // err
        //NSString *remoteDomain = @"baidu.com";
        //NSString *remoteDomain = @"www.baidu.com";
        //NSString *remoteDomain = @"push.pushsystem.serverddc.com";
        const char *cc = [remoteDomain cStringUsingEncoding:NSASCIIStringEncoding];
        struct hostent *remoteHostent = gethostbyname(cc);
        if (!remoteHostent) {
            NSLog(@"err");
            return nil;
        }
        struct in_addr *remoteInAddr = (struct in_addr *)remoteHostent->h_addr_list[0];
        char *cRemoteInAddr = inet_ntoa(*remoteInAddr);
        NSString *ip = [[NSString alloc] initWithCString:cRemoteInAddr encoding:NSASCIIStringEncoding];
        //NSLog(@"ip:%@", ip);
        return ip;
    }



@end
