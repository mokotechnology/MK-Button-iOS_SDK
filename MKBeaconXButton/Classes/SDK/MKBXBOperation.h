//
//  MKBXBOperation.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKBXBOperationID.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBOperation : NSOperation<MKBLEBaseOperationProtocol>

/**
 初始化通信线程
 
 @param operationID 当前线程的任务ID
 @param resetNum 是否需要根据外设返回的数据总条数来修改任务需要接受的数据总条数，YES需要，NO不需要
 @param commandBlock 发送命令回调
 @param completeBlock 数据通信完成回调
 @return operation
 */
- (instancetype)initOperationWithID:(mk_bxb_taskOperationID)operationID
                       commandBlock:(void (^)(void))commandBlock
                      completeBlock:(void (^)(NSError * _Nullable error, id _Nullable returnData))completeBlock;

@end

NS_ASSUME_NONNULL_END
