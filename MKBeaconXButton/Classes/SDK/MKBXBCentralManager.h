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

/*
 After connecting the device, if no password is entered within one minute, it returns 0x01. After successful password change, it returns 0x02.The device reset ,it returns 0x03.Power Off the device ,it returns 0x04.
 */
extern NSString *const mk_bxb_deviceDisconnectTypeNotification;

/*
 The current trigger record returned by the device.
        @{
    @"timestamp":timestamp,         //Record trigger timestamp (accurate to millisecond level).
     @"alarmType":alarmType,        //Type of trigger.(00:Single press event  01:Double press event 02:Long press event )
 }
 
 */
extern NSString *const mk_bxb_receiveAlarmEventDataNotification;

extern NSString *const mk_bxb_receiveThreeAxisDataNotification;

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
/// @param deviceList deviceList
- (void)mk_bxb_receiveAdvData:(NSArray <MKBXBBaseAdvModel *>*)deviceList;

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

/// Read whether a connected device requires a password.
/*
 @{
 @"state":@"00",            //@"00":Password-free connection   @"01":password connection
 }
 */
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)readNeedPasswordWithPeripheral:(nonnull CBPeripheral *)peripheral
                              sucBlock:(void (^)(NSDictionary *result))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Connect device function.
/// @param peripheral peripheral
/// @param password Device connection password.No more than 16 characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Connect device function.
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
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

/// Alarm event data(Single press event.).
/// @param notify notify
- (BOOL)notifySinglePressEventData:(BOOL)notify;

/// Alarm event data(Double press event.).
/// @param notify notify
- (BOOL)notifyDoublePressEventData:(BOOL)notify;

/// Alarm event data(Long press event.).
/// @param notify notify
- (BOOL)notifyLongPressEventData:(BOOL)notify;

/// Monitor three-axis accelerometer data.
/// @param notify notify
- (BOOL)notifyThreeAxisData:(BOOL)notify;

@end

NS_ASSUME_NONNULL_END
