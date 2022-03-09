//
//  MKBXBTaskAdopter.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKBXBOperationID.h"
#import "MKBXBAdopter.h"

@implementation MKBXBTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_bxb_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A25"]]) {
        //生产日期
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"productionDate":tempString} operationID:mk_bxb_taskReadProductionDateOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_bxb_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_bxb_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_bxb_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_bxb_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        //custom
        return [self parseCustomData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA07"]]) {
        //密码
        return [self parsePasswordData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    if (![[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"eb"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        //设置
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_bxb_taskOperationID operationID = mk_bxb_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"20"]) {
        //读取MAC地址
        operationID = mk_bxb_taskReadMacAddressOperation;
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
    }else if ([cmd isEqualToString:@"21"]){
        //读取三轴传感器参数
        operationID = mk_bxb_taskReadThreeAxisDataParamsOperation;
        resultDic = @{
                      @"samplingRate":[content substringWithRange:NSMakeRange(0, 2)],
                      @"fullScale":[content substringWithRange:NSMakeRange(2, 2)],
                      @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)],
                      };
    }else if ([cmd isEqualToString:@"22"]) {
        //读取可连接状态
        operationID = mk_bxb_taskReadConnectableOperation;
        BOOL connectable = [content isEqualToString:@"01"];
        resultDic = @{
            @"connectable":@(connectable)
        };
    }else if ([cmd isEqualToString:@"23"]) {
        //读取密码验证状态
        operationID = mk_bxb_taskReadPasswordVerificationOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn)
        };
    }else if ([cmd isEqualToString:@"24"]) {
        //读取设备连接密码
        operationID = mk_bxb_taskReadConnectPasswordOperation;
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
    }else if ([cmd isEqualToString:@"25"]) {
        //读取连续按键有效时长
        operationID = mk_bxb_taskReadEffectiveClickIntervalOperation;
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 4)];
        resultDic = @{
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"29"]) {
        //读取按键开关及状态
        operationID = mk_bxb_taskReadTurnOffDeviceByButtonStatusOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn)
        };
    }else if ([cmd isEqualToString:@"2f"]) {
        //读取回应包开关
        operationID = mk_bxb_taskReadScanResponsePacketOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn)
        };
    }else if ([cmd isEqualToString:@"31"]) {
        //读取按键是否可以恢复出厂设置
        operationID = mk_bxb_taskReadResetDeviceByButtonStatusOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn)
        };
    }else if ([cmd isEqualToString:@"32"]) {
        //读取各通道广播使能情况
        operationID = mk_bxb_taskReadTriggerChannelStateOperation;
        NSString *singleState = [content substringWithRange:NSMakeRange(0, 2)];
        NSString *doubleState = [content substringWithRange:NSMakeRange(2, 2)];
        NSString *longState = [content substringWithRange:NSMakeRange(4, 2)];
        NSString *inactivityState = [content substringWithRange:NSMakeRange(6, 2)];
        resultDic = @{
            @"singlePressMode":@([singleState isEqualToString:@"01"]),
            @"doublePressMode":@([doubleState isEqualToString:@"01"]),
            @"longPressMode":@([longState isEqualToString:@"01"]),
            @"abnormalInactivityMode":@([inactivityState isEqualToString:@"01"]),
        };
    }else if ([cmd isEqualToString:@"34"]) {
        //读取活跃通道广播参数
        operationID = mk_bxb_taskReadTriggerChannelAdvParamsOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        BOOL isOn = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(4, 2)]];
        NSInteger advInterval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(6, 4)];
        NSString *txPower = [MKBXBAdopter fetchTxPowerValueString:[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{
            @"channelType":channelType,
            @"isOn":@(isOn),
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[rssi integerValue]],
            @"advInterval":[NSString stringWithFormat:@"%ld",(long)(advInterval / 20)],
            @"txPower":txPower,
        };
    }else if ([cmd isEqualToString:@"35"]) {
        //读取活跃通道触发广播参数
        operationID = mk_bxb_taskReadChannelTriggerParamsOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        BOOL alarm = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(4, 2)]];
        NSInteger advInterval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(6, 4)];
        NSString *txPower = [MKBXBAdopter fetchTxPowerValueString:[content substringWithRange:NSMakeRange(10, 2)]];
        NSString *advTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(12, 4)];
        resultDic = @{
            @"channelType":channelType,
            @"alarm":@(alarm),
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[rssi integerValue]],
            @"advInterval":[NSString stringWithFormat:@"%ld",(long)(advInterval / 20)],
            @"txPower":txPower,
            @"advTime":advTime,
        };
    }else if ([cmd isEqualToString:@"36"]) {
        //读取活跃通道触发前广播开关
        operationID = mk_bxb_taskReadStayAdvertisingBeforeTriggeredOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        BOOL isOn = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
        resultDic = @{
            @"channelType":channelType,
            @"isOn":@(isOn),
        };
    }else if ([cmd isEqualToString:@"37"]) {
        //读取触发提醒模式
        operationID = mk_bxb_taskReadAlarmNotificationTypeOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        NSString *alarmNotiType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"channelType":channelType,
            @"alarmNotificationType":alarmNotiType,
        };
    }else if ([cmd isEqualToString:@"38"]) {
        //读取异常活动报警静止时间
        operationID = mk_bxb_taskReadAbnormalInactivityTimeOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"time":time
        };
    }else if ([cmd isEqualToString:@"39"]) {
        //读取省电模式开关
        operationID = mk_bxb_taskReadPowerSavingModeOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn)
        };
    }else if ([cmd isEqualToString:@"3a"]) {
        //读取省电模式静止时间
        operationID = mk_bxb_taskReadStaticTriggerTimeOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"time":time
        };
    }else if ([cmd isEqualToString:@"3b"]) {
        //读取通道触发LED提醒参数
        operationID = mk_bxb_taskReadAlarmLEDNotiParamsOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"channelType":channelType,
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"3c"]) {
        //读取通道触发马达提醒参数
        operationID = mk_bxb_taskReadAlarmVibrationNotiParamsOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"channelType":channelType,
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"3d"]) {
        //读取通道触发蜂鸣器提醒参数
        operationID = mk_bxb_taskReadAlarmBuzzerNotiParamsOperation;
        NSString *channelType = [content substringWithRange:NSMakeRange(0, 2)];
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"channelType":channelType,
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"3e"]) {
        //读取远程LED提醒参数
        operationID = mk_bxb_taskReadRemoteReminderLEDNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"3f"]) {
        //读取远程马达提醒参数
        operationID = mk_bxb_taskReadRemoteReminderVibrationNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"40"]) {
        //读取远程蜂鸣器提醒参数
        operationID = mk_bxb_taskReadRemoteReminderBuzzerNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"42"]) {
        //读取按键消警使能
        operationID = mk_bxb_taskReadDismissAlarmByButtonOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn)
        };
    }else if ([cmd isEqualToString:@"43"]) {
        //读取LED消警参数
        operationID = mk_bxb_taskReadDismissAlarmLEDNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"44"]) {
        //读取马达消警参数
        operationID = mk_bxb_taskReadDismissAlarmVibrationNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"45"]) {
        //读取蜂鸣器消警参数
        operationID = mk_bxb_taskReadDismissAlarmBuzzerNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"46"]) {
        //读取消警提醒模式
        operationID = mk_bxb_taskReadDismissAlarmNotificationTypeOperation;
        NSString *alarmNotiType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"type":alarmNotiType,
        };
    }else if ([cmd isEqualToString:@"4a"]) {
        //读取电池电压
        operationID = mk_bxb_taskReadBatteryVoltageOperation;
        NSString *voltage = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"voltage":voltage,
        };
    }else if ([cmd isEqualToString:@"4b"]) {
        //读取设备时间
        operationID = mk_bxb_taskReadDeviceTimeOperation;
        NSString *timestamp = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"timestamp":timestamp};
    }else if ([cmd isEqualToString:@"4f"]) {
        //读取传感器状态
        operationID = mk_bxb_taskReadSensorStatusOperation;
        NSString *bit = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL threeAxis = [[bit substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL htSensor = [[bit substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL lightSensor = [[bit substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        resultDic = @{
            @"threeAxis":@(threeAxis),
            @"htSensor":@(htSensor),
            @"lightSensor":@(lightSensor)
        };
    }else if ([cmd isEqualToString:@"50"]) {
        //读取deviceID
        operationID = mk_bxb_taskReadDeviceIDOperation;
        resultDic = @{
            @"deviceID":content,
        };
    }else if ([cmd isEqualToString:@"51"]) {
        //读取设备名称
        operationID = mk_bxb_taskReadDeviceNameOperation;
        NSString *deviceName = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, data.length - 4)] encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
    }else if ([cmd isEqualToString:@"52"]) {
        //读取单击触发次数
        operationID = mk_bxb_taskReadSinglePressEventCountOperation;
        NSString *count = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"count":count,
        };
    }else if ([cmd isEqualToString:@"53"]) {
        //读取双击触发次数
        operationID = mk_bxb_taskReadDoublePressEventCountOperation;
        NSString *count = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"count":count,
        };
    }else if ([cmd isEqualToString:@"54"]) {
        //读取长按触发次数
        operationID = mk_bxb_taskReadLongPressEventCountOperation;
        NSString *count = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"count":count,
        };
    }else if ([cmd isEqualToString:@"57"]) {
        //读取设备类型
        operationID = mk_bxb_taskReadDeviceTypeOperation;
        resultDic = @{
            @"deviceType":content,
        };
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_bxb_taskOperationID operationID = mk_bxb_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"aa"];
    
    if ([cmd isEqualToString:@"21"]) {
        //设置三轴传感器参数
        operationID = mk_bxb_taskConfigThreeAxisDataParamsOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //设置可连接性
        operationID = mk_bxb_taskConfigConnectableOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //设置密码验证状态
        operationID = mk_bxb_taskConfigPasswordVerificationOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //设置连接密码
        operationID = mk_bxb_taskConfigConnectPasswordOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //设置连续按键有效时长
        operationID = mk_bxb_taskConfigEffectiveClickIntervalOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //关机
        operationID = mk_bxb_taskConfigPowerOffOperation;
    }else if ([cmd isEqualToString:@"28"]) {
        //恢复出厂设置
        operationID = mk_bxb_taskConfigFactoryResetOperation;
    }else if ([cmd isEqualToString:@"29"]) {
        //设置按键开关机状态
        operationID = mk_bxb_taskConfigTurnOffDeviceByButtonStatusOperation;
    }else if ([cmd isEqualToString:@"2f"]) {
        //设置回应包开关
        operationID = mk_bxb_taskConfigScanResponsePacketOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //设置按键是否可以恢复出厂设置
        operationID = mk_bxb_taskConfigResetDeviceByButtonStatusOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //设置活跃通道广播参数
        operationID = mk_bxb_taskConfigTriggerChannelAdvParamsOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //设置活跃通道触发广播参数
        operationID = mk_bxb_taskConfigChannelTriggerParamsOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //设置活跃通道触发前广播开关
        operationID = mk_bxb_taskConfigStayAdvertisingBeforeTriggeredOperation;
    }else if ([cmd isEqualToString:@"37"]) {
        //设置触发提醒模式
        operationID = mk_bxb_taskConfigAlarmNotificationTypeOperation;
    }else if ([cmd isEqualToString:@"38"]) {
        //设置异常活动报警静止时间
        operationID = mk_bxb_taskConfigAbnormalInactivityTimeOperation;
    }else if ([cmd isEqualToString:@"39"]) {
        //设置省电模式开关
        operationID = mk_bxb_taskConfigPowerSavingModeOperation;
    }else if ([cmd isEqualToString:@"3a"]) {
        //设置省电模式静止时间
        operationID = mk_bxb_taskConfigStaticTriggerTimeOperation;
    }else if ([cmd isEqualToString:@"3b"]) {
        //设置通道触发LED提醒参数
        operationID = mk_bxb_taskConfigAlarmLEDNotiParamsOperation;
    }else if ([cmd isEqualToString:@"3c"]) {
        //设置通道触发马达提醒参数
        operationID = mk_bxb_taskConfigAlarmVibrationNotiParamsOperation;
    }else if ([cmd isEqualToString:@"3d"]) {
        //设置通道触发蜂鸣器提醒参数
        operationID = mk_bxb_taskConfigAlarmBuzzerNotiParamsOperation;
    }else if ([cmd isEqualToString:@"3e"]) {
        //设置远程LED提醒参数
        operationID = mk_bxb_taskConfigRemoteReminderLEDNotiParamsOperation;
    }else if ([cmd isEqualToString:@"3f"]) {
        //设置远程马达提醒参数
        operationID = mk_bxb_taskConfigRemoteReminderVibrationNotiParamsOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //设置远程蜂鸣器提醒参数
        operationID = mk_bxb_taskConfigRemoteReminderBuzzerNotiParamsOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //设置远程消警
        operationID = mk_bxb_taskConfigDismissAlarmOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //设置按键消警使能
        operationID = mk_bxb_taskConfigDismissAlarmByButtonOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //设置远程LED消警参数
        operationID = mk_bxb_taskConfigDismissAlarmLEDNotiParamsOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //设置远程马达消警参数
        operationID = mk_bxb_taskConfigDismissAlarmVibrationNotiParamsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //设置远程蜂鸣器消警参数
        operationID = mk_bxb_taskConfigDismissAlarmBuzzerNotiParamsOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //设置消警提醒模式
        operationID = mk_bxb_taskConfigDismissAlarmNotificationTypeOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //删除单击通道触发记录
        operationID = mk_bxb_taskClearSinglePressEventDataOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //删除双击通道触发记录
        operationID = mk_bxb_taskClearDoublePressEventDataOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //删除长按通道触发记录
        operationID = mk_bxb_taskClearLongPressEventDataOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //设置设备时间
        operationID = mk_bxb_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //设置deviceID
        operationID = mk_bxb_taskConfigDeviceIDOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //设置设备名称
        operationID = mk_bxb_taskConfigDeviceNameOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}

+ (NSDictionary *)parsePasswordData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    if (![[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"eb"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    
    mk_bxb_taskOperationID operationID = mk_bxb_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    if ([cmd isEqualToString:@"23"]) {
        //读取设备连接是否需要密码
        operationID = mk_bxb_taskReadNeedPasswordOperation;
        resultDic = @{
            @"state":content
        };
    }else if ([cmd isEqualToString:@"55"]) {
        //验证密码
        operationID = mk_bxb_connectPasswordOperation;
        
        resultDic = @{
            @"success":@([content isEqualToString:@"aa"]),
        };
    }
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

#pragma mark - private method
+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_bxb_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
