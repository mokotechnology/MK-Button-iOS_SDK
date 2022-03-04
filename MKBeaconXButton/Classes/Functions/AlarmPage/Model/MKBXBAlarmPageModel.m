//
//  MKBXBAlarmPageModel.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBAlarmPageModel.h"

#import "MKMacroDefines.h"

#import "MKBXBInterface.h"

@interface MKBXBAlarmPageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBXBAlarmPageModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAlarmStatus]) {
            [self operationFailedBlockWithMsg:@"Read Alarm Status Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readAlarmStatus {
    __block BOOL success = NO;
    [MKBXBInterface bxb_readTriggerChannelStateWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.singleIsOn = [returnData[@"result"][@"singlePressMode"] boolValue];
        self.doubleIsOn = [returnData[@"result"][@"doublePressMode"] boolValue];
        self.longIsOn = [returnData[@"result"][@"longPressMode"] boolValue];
        self.inactivityIsOn = [returnData[@"result"][@"abnormalInactivityMode"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"ALARMParams"
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
        _readQueue = dispatch_queue_create("ALARMQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
