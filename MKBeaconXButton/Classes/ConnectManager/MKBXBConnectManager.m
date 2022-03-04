//
//  MKBXBConnectManager.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBConnectManager.h"

@implementation MKBXBConnectManager

+ (MKBXBConnectManager *)shared {
    static MKBXBConnectManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[MKBXBConnectManager alloc] init];
        }
    });
    return manager;
}

@end
