//
//  MKBXBInterface+MKBXBConfig.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBInterface+MKBXBConfig.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKBXBCentralManager.h"
#import "MKBXBOperationID.h"
#import "MKBXBOperation.h"
#import "CBPeripheral+MKBXBAdd.h"
#import "MKBXBAdopter.h"

#define centralManager [MKBXBCentralManager shared]

@implementation MKBXBInterface (MKBXBConfig)
+ (void)bxb_configThreeAxisDataParams:(mk_bxb_threeAxisDataRate)dataRate
                            fullScale:(mk_bxb_threeAxisDataAG)fullScale
                      motionThreshold:(NSInteger)motionThreshold
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (motionThreshold < 1 || motionThreshold > 2048) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *rate = [MKBXBAdopter fetchThreeAxisDataRate:dataRate];
    NSString *ag = [MKBXBAdopter fetchThreeAxisDataAG:fullScale];
    NSString *sen = [MKBLEBaseSDKAdopter fetchHexValue:motionThreshold byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ea012104",rate,ag,sen];
    [self configDataWithTaskID:mk_bxb_taskConfigThreeAxisDataParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configConnectable:(BOOL)connectable
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (connectable ? @"ea01220101" : @"ea01220100");
    [self configDataWithTaskID:mk_bxb_taskConfigConnectableOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configPasswordVerification:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea01230101" : @"ea01230100");
    [self configDataWithTaskID:mk_bxb_taskConfigPasswordVerificationOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configConnectPassword:(NSString *)password
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(password) || password.length > 16) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < password.length; i ++) {
        int asciiCode = [password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)password.length];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea0124",lenString,commandData];
    [self configDataWithTaskID:mk_bxb_taskConfigConnectPasswordOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configEffectiveClickInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 5 || interval > 15) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *intervalValue = [MKBLEBaseSDKAdopter fetchHexValue:(interval * 100) byteLen:2];
    NSString *commandString = [@"ea012502" stringByAppendingString:intervalValue];
    [self configDataWithTaskID:mk_bxb_taskConfigEffectiveClickIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_powerOffWithSucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea012600";
    [self configDataWithTaskID:mk_bxb_taskConfigPowerOffOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_factoryResetWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea012800";
    [self configDataWithTaskID:mk_bxb_taskConfigFactoryResetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configTurnOffDeviceByButtonStatus:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea01290101" : @"ea01290100");
    [self configDataWithTaskID:mk_bxb_taskConfigTurnOffDeviceByButtonStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configScanResponsePacket:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea012f0101" : @"ea012f0100");
    [self configDataWithTaskID:mk_bxb_taskConfigScanResponsePacketOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configResetDeviceByButtonStatus:(BOOL)isOn
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea01310101" : @"ea01310100");
    [self configDataWithTaskID:mk_bxb_taskConfigResetDeviceByButtonStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configTriggerChannelAdvParams:(id <MKBXBTriggerChannelAdvParamsProtocol>)protocol
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    if (![MKBXBAdopter validTriggerChannelAdvParamsProtocol:protocol]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [MKBXBAdopter parseTriggerChannelAdvParamsProtocol:protocol];
    [self configDataWithTaskID:mk_bxb_taskConfigTriggerChannelAdvParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configChannelTriggerParams:(id <MKBXBChannelTriggerParamsProtocol>)protocol
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (![MKBXBAdopter validChannelTriggerParamsProtocol:protocol]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [MKBXBAdopter parseChannelTriggerParamsProtocol:protocol];
    [self configDataWithTaskID:mk_bxb_taskConfigChannelTriggerParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configStayAdvertisingBeforeTriggered:(MKBXBChannelAlarmType)channelType
                                            isOn:(BOOL)isOn
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = [MKBLEBaseSDKAdopter fetchHexValue:channelType byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea013602",type,(isOn ? @"01" : @"00")];
    [self configDataWithTaskID:mk_bxb_taskConfigStayAdvertisingBeforeTriggeredOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configAlarmNotificationType:(MKBXBChannelAlarmType)channelType
                           reminderType:(mk_bxb_reminderType)reminderType
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *channleType = [MKBLEBaseSDKAdopter fetchHexValue:channelType byteLen:1];
    NSString *typeString = [MKBXBAdopter fetchReminderTypeString:reminderType];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea013702",channleType,typeString];
    [self configDataWithTaskID:mk_bxb_taskConfigAlarmNotificationTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configAbnormalInactivityTime:(NSInteger)time
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *commandString = [@"ea013802" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bxb_taskConfigAbnormalInactivityTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configPowerSavingMode:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea01390101" : @"ea01390100");
    [self configDataWithTaskID:mk_bxb_taskConfigPowerSavingModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configStaticTriggerTime:(NSInteger)time
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *commandString = [@"ea013a02" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bxb_taskConfigStaticTriggerTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configAlarmLEDNotiParams:(MKBXBChannelAlarmType)channelType
                        blinkingTime:(NSInteger)blinkingTime
                    blinkingInterval:(NSInteger)blinkingInterval
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (blinkingTime < 1 || blinkingTime > 6000 || blinkingInterval < 1 || blinkingInterval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *channleType = [MKBLEBaseSDKAdopter fetchHexValue:channelType byteLen:1];
    NSString *time = [MKBLEBaseSDKAdopter fetchHexValue:blinkingTime byteLen:2];
    NSString *interval = [MKBLEBaseSDKAdopter fetchHexValue:(blinkingInterval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ea013b05",channleType,time,interval];
    [self configDataWithTaskID:mk_bxb_taskConfigAlarmLEDNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configAlarmVibrationNotiParams:(MKBXBChannelAlarmType)channelType
                             vibratingTime:(NSInteger)vibratingTime
                         vibratingInterval:(NSInteger)vibratingInterval
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    if (vibratingTime < 1 || vibratingTime > 6000 || vibratingInterval < 1 || vibratingInterval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *channleType = [MKBLEBaseSDKAdopter fetchHexValue:channelType byteLen:1];
    NSString *time = [MKBLEBaseSDKAdopter fetchHexValue:vibratingTime byteLen:2];
    NSString *interval = [MKBLEBaseSDKAdopter fetchHexValue:(vibratingInterval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ea013c05",channleType,time,interval];
    [self configDataWithTaskID:mk_bxb_taskConfigAlarmVibrationNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configAlarmBuzzerNotiParams:(MKBXBChannelAlarmType)channelType
                            ringingTime:(NSInteger)ringingTime
                        ringingInterval:(NSInteger)ringingInterval
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    if (ringingTime < 1 || ringingTime > 6000 || ringingInterval < 1 || ringingInterval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *channleType = [MKBLEBaseSDKAdopter fetchHexValue:channelType byteLen:1];
    NSString *time = [MKBLEBaseSDKAdopter fetchHexValue:ringingTime byteLen:2];
    NSString *interval = [MKBLEBaseSDKAdopter fetchHexValue:(ringingInterval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ea013d05",channleType,time,interval];
    [self configDataWithTaskID:mk_bxb_taskConfigAlarmBuzzerNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configRemoteReminderLEDNotiParams:(NSInteger)blinkingTime
                             blinkingInterval:(NSInteger)blinkingInterval
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (blinkingTime < 1 || blinkingTime > 6000 || blinkingInterval < 1 || blinkingInterval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *time = [MKBLEBaseSDKAdopter fetchHexValue:blinkingTime byteLen:2];
    NSString *interval = [MKBLEBaseSDKAdopter fetchHexValue:(blinkingInterval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea013e04",time,interval];
    [self configDataWithTaskID:mk_bxb_taskConfigRemoteReminderLEDNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configRemoteReminderVibrationNotiParams:(NSInteger)vibratingTime
                                  vibratingInterval:(NSInteger)vibratingInterval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (vibratingTime < 1 || vibratingTime > 6000 || vibratingInterval < 1 || vibratingInterval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *time = [MKBLEBaseSDKAdopter fetchHexValue:vibratingTime byteLen:2];
    NSString *interval = [MKBLEBaseSDKAdopter fetchHexValue:(vibratingInterval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea013f04",time,interval];
    [self configDataWithTaskID:mk_bxb_taskConfigRemoteReminderVibrationNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configRemoteReminderBuzzerNotiParams:(NSInteger)ringingTime
                                 ringingInterval:(NSInteger)ringingInterval
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (ringingTime < 1 || ringingTime > 6000 || ringingInterval < 1 || ringingInterval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *time = [MKBLEBaseSDKAdopter fetchHexValue:ringingTime byteLen:2];
    NSString *interval = [MKBLEBaseSDKAdopter fetchHexValue:(ringingInterval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea014004",time,interval];
    [self configDataWithTaskID:mk_bxb_taskConfigRemoteReminderBuzzerNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea014100";
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmByButton:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea01420101" : @"ea01420100");
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmByButtonOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmLEDNotiParams:(NSInteger)time
                                   interval:(NSInteger)interval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 6000 || interval < 1 || interval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeValue = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *intervalValue = [MKBLEBaseSDKAdopter fetchHexValue:(interval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea014304",timeValue,intervalValue];
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmLEDNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmVibrationNotiParams:(NSInteger)time
                                         interval:(NSInteger)interval
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 6000 || interval < 1 || interval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeValue = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *intervalValue = [MKBLEBaseSDKAdopter fetchHexValue:(interval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea014404",timeValue,intervalValue];
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmVibrationNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmBuzzerNotiParams:(NSInteger)time
                                      interval:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 6000 || interval < 1 || interval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeValue = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *intervalValue = [MKBLEBaseSDKAdopter fetchHexValue:(interval * 100) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea014504",timeValue,intervalValue];
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmBuzzerNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmNotificationType:(mk_bxb_reminderType)type
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *typeString = [MKBXBAdopter fetchReminderTypeString:type];
    NSString *commandString = [@"ea014601" stringByAppendingString:typeString];
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmNotificationTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_clearSinglePressEventDataWithSucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea014700";
    [self configDataWithTaskID:mk_bxb_taskClearSinglePressEventDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_clearDoublePressEventDataWithSucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea014800";
    [self configDataWithTaskID:mk_bxb_taskClearDoublePressEventDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_clearLongPressEventDataWithSucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea014900";
    [self configDataWithTaskID:mk_bxb_taskClearLongPressEventDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDeviceTime:(long long)timestamp
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (timestamp < 0) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:timestamp byteLen:8];
    NSString *commandString = [@"ea014b08" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bxb_taskConfigDeviceTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDeviceID:(NSString *)deviceID
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(deviceID) || deviceID.length > 12 || ![MKBLEBaseSDKAdopter checkHexCharacter:deviceID]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:(deviceID.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea0150",len,deviceID];
    [self configDataWithTaskID:mk_bxb_taskConfigDeviceIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDeviceName:(NSString *)deviceName
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(deviceName) || deviceName.length > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < deviceName.length; i ++) {
        int asciiCode = [deviceName characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)deviceName.length];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
    NSString *commandString = [NSString stringWithFormat:@"ea0151%@%@",lenString,tempString];
    [self configDataWithTaskID:mk_bxb_taskConfigDeviceNameOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark - private method
+ (void)configDataWithTaskID:(mk_bxb_taskOperationID)taskID
                        data:(NSString *)data
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:taskID characteristic:centralManager.peripheral.bxb_custom commandData:data successBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"result"][@"success"] boolValue];
        if (!success) {
            [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

@end
