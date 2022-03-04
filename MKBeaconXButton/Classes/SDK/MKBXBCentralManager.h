//
//  MKBXBCentralManager.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKBXBOperationID.h"

@class CBCentralManager,CBPeripheral;
@class MKBXBBaseAdvModel;

NS_ASSUME_NONNULL_BEGIN

//Notification of device connection status changes.
extern NSString *const mk_bxb_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_bxb_centralManagerStateChangedNotification;

typedef NS_ENUM(NSInteger, mk_bxb_centralManagerStatus) {
    mk_bxb_centralManagerStatusUnable,                           //不可用
    mk_bxb_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_bxb_centralConnectStatus) {
    mk_bxb_centralConnectStatusUnknow,                                           //未知状态
    mk_bxb_centralConnectStatusConnecting,                                       //正在连接
    mk_bxb_centralConnectStatusConnected,                                        //连接成功
    mk_bxb_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_bxb_centralConnectStatusDisconnect,
};

@protocol mk_bxb_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param advModel device
- (void)mk_bxb_receiveAdvData:(MKBXBBaseAdvModel *)advModel;

@optional

/// Starts scanning equipment.
- (void)mk_bxb_startScan;

/// Stops scanning equipment.
- (void)mk_bxb_stopScan;

@end

@interface MKBXBCentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_bxb_centralManagerScanDelegate>delegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_bxb_centralConnectStatus connectStatus;

+ (MKBXBCentralManager *)shared;

/// Destroy the MKBXBCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKBXBCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_bxb_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning
- (void)startScan;

/// Bluetooth center stops scanning
- (void)stopScan;

/// Connect device function.
/// @param peripheral peripheral
/// @param password Device connection password.No more than 16 characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnect;

/// Start a task for data communication with the device
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param commandData Data to be sent to the device for this communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addTaskWithTaskID:(mk_bxb_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

/// Start a task to read device characteristic data
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addReadTaskWithTaskID:(mk_bxb_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
