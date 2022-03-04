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
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ea310004",rate,ag,sen];
    [self configDataWithTaskID:mk_bxb_taskConfigThreeAxisDataParamsOperation
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
    NSString *commandString = [@"ea350002" stringByAppendingString:intervalValue];
    [self configDataWithTaskID:mk_bxb_taskConfigEffectiveClickIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configActiveChannel:(MKBXBChannelAlarmType)alarmType
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = @"00";
    if (alarmType == MKBXBChannelAlarmType_double) {
        type = @"01";
    }else if (alarmType == MKBXBChannelAlarmType_long) {
        type = @"02";
    }else if (alarmType == MKBXBChannelAlarmType_abnormalInactivity) {
        type = @"03";
    }
    NSString *commandString = [@"ea530001" stringByAppendingString:type];
    [self configDataWithTaskID:mk_bxb_taskConfigActiveChannelOperation
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

+ (void)bxb_configStayAdvertisingBeforeTriggered:(BOOL)isOn
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea56000101" : @"ea56000100");
    [self configDataWithTaskID:mk_bxb_taskConfigStayAdvertisingBeforeTriggeredOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configAlarmNotificationType:(mk_bxb_reminderType)type
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *typeString = [MKBXBAdopter fetchReminderTypeString:type];
    NSString *commandString = [@"ea570001" stringByAppendingString:typeString];
    [self configDataWithTaskID:mk_bxb_taskConfigAlarmNotificationTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea610000";
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_clearSinglePressEventDataWithSucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea670000";
    [self configDataWithTaskID:mk_bxb_taskClearSinglePressEventDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_clearDoublePressEventDataWithSucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea680000";
    [self configDataWithTaskID:mk_bxb_taskClearDoublePressEventDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_clearLongPressEventDataWithSucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea690000";
    [self configDataWithTaskID:mk_bxb_taskClearLongPressEventDataOperation
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
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea730004",timeValue,intervalValue];
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
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea740004",timeValue,intervalValue];
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
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea750004",timeValue,intervalValue];
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmBuzzerNotiParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDismissAlarmNotificationType:(mk_bxb_reminderType)type
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *typeString = [MKBXBAdopter fetchReminderTypeString:type];
    NSString *commandString = [@"ea760001" stringByAppendingString:typeString];
    [self configDataWithTaskID:mk_bxb_taskConfigDismissAlarmNotificationTypeOperation
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
    NSString *commandString = [@"ea7b0008" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bxb_taskConfigDeviceTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bxb_configDeviceID:(NSString *)deviceID
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(deviceID) || deviceID.length > 16 || ![MKBLEBaseSDKAdopter checkHexCharacter:deviceID]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:(deviceID.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ea9000",len,deviceID];
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
    NSString *commandString = [NSString stringWithFormat:@"ea9100%@%@",lenString,tempString];
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
    [centralManager addTaskWithTaskID:taskID characteristic:centralManager.peripheral.bxb_customWrite commandData:data successBlock:^(id  _Nonnull returnData) {
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
