//
//  MKBXBAlarmNotiTypeModel.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBAlarmNotiTypeModel.h"

#import "MKMacroDefines.h"

#import "MKBXBInterface.h"
#import "MKBXBInterface+MKBXBConfig.h"

@interface MKBXBAlarmNotiTypeModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBXBAlarmNotiTypeModel

#pragma mark - interface


#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"AlarmNotiTypeParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("AlarmNotiTypeQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
