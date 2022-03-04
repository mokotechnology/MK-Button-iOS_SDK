//
//  MKBXBInterface.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBInterface.h"

#import "MKBXBCentralManager.h"
#import "MKBXBOperationID.h"
#import "MKBXBOperation.h"
#import "CBPeripheral+MKBXBAdd.h"

#define centralManager [MKBXBCentralManager shared]
#define peripheral ([MKBXBCentralManager shared].peripheral)

@implementation MKBXBInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)bxb_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bxb_taskReadDeviceModelOperation
                           characteristic:peripheral.bxb_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bxb_readProductionDateWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bxb_taskReadProductionDateOperation
                           characteristic:peripheral.bxb_productionDate
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bxb_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bxb_taskReadFirmwareOperation
                           characteristic:peripheral.bxb_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bxb_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bxb_taskReadHardwareOperation
                           characteristic:peripheral.bxb_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bxb_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bxb_taskReadSoftwareOperation
                           characteristic:peripheral.bxb_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bxb_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bxb_taskReadManufacturerOperation
                           characteristic:peripheral.bxb_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark - custom
+ (void)bxb_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadMacAddressOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readThreeAxisDataParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadThreeAxisDataParamsOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readEffectiveClickIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadEffectiveClickIntervalOperation
                     cmdFlag:@"25"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readTriggerChannelStateWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadTriggerChannelStateOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readTriggerChannelAdvParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadTriggerChannelAdvParamsOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readChannelTriggerParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadChannelTriggerParamsOperation
                     cmdFlag:@"45"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readStayAdvertisingBeforeTriggeredWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadStayAdvertisingBeforeTriggeredOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readAlarmNotificationTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadAlarmNotificationTypeOperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDismissAlarmLEDNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDismissAlarmLEDNotiParamsOperation
                     cmdFlag:@"63"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDismissAlarmVibrationNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDismissAlarmVibrationNotiParamsOperation
                     cmdFlag:@"64"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDismissAlarmBuzzerNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDismissAlarmBuzzerNotiParamsOperation
                     cmdFlag:@"65"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDismissAlarmNotificationTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDismissAlarmNotificationTypeOperation
                     cmdFlag:@"66"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadBatteryVoltageOperation
                     cmdFlag:@"6a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDeviceTimeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDeviceTimeOperation
                     cmdFlag:@"6b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDeviceIDWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDeviceIDOperation
                     cmdFlag:@"80"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDeviceNameOperation
                     cmdFlag:@"81"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readSinglePressEventCountWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadSinglePressEventCountOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readDoublePressEventCountWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadDoublePressEventCountOperation
                     cmdFlag:@"83"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bxb_readLongPressEventCountWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bxb_taskReadLongPressEventCountOperation
                     cmdFlag:@"84"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method
+ (void)readDataWithTaskID:(mk_bxb_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea",flag,@"0000"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.bxb_customWrite
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
