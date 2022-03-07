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
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"fee2"]]) {
        //custom
        return [self parseCustomData:readData];
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
    NSString *cmd = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    
    mk_bxb_taskOperationID operationID = mk_bxb_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@""]) {
        
    }else if ([cmd isEqualToString:@"20"]) {
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
    }else if ([cmd isEqualToString:@"25"]) {
        //读取连续按键有效时长
        operationID = mk_bxb_taskReadEffectiveClickIntervalOperation;
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 4)];
        resultDic = @{
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"31"]) {
        //设置三轴传感器参数
        operationID = mk_bxb_taskConfigThreeAxisDataParamsOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"35"]) {
        //设置连续按键有效时长
        operationID = mk_bxb_taskConfigEffectiveClickIntervalOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"3f"]) {
        //设置回应包开关
        operationID = mk_bxb_taskConfigScanResponsePacketOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"42"]) {
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
    }else if ([cmd isEqualToString:@"44"]) {
        //读取活跃通道广播参数
        operationID = mk_bxb_taskReadTriggerChannelAdvParamsOperation;
        BOOL isOn = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(2, 2)]];
        NSInteger advInterval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        NSString *txPower = [MKBXBAdopter fetchTxPowerValueString:[content substringWithRange:NSMakeRange(8, 2)]];
        resultDic = @{
            @"isOn":@(isOn),
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[rssi integerValue]],
            @"advInterval":[NSString stringWithFormat:@"%ld",(long)(advInterval / 20)],
            @"txPower":txPower,
        };
    }else if ([cmd isEqualToString:@"45"]) {
        //读取活跃通道触发广播参数
        operationID = mk_bxb_taskReadChannelTriggerParamsOperation;
        BOOL alarm = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(2, 2)]];
        NSInteger advInterval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        NSString *txPower = [MKBXBAdopter fetchTxPowerValueString:[content substringWithRange:NSMakeRange(8, 2)]];
        NSString *advTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
        resultDic = @{
            @"alarm":@(alarm),
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[rssi integerValue]],
            @"advInterval":[NSString stringWithFormat:@"%ld",(long)(advInterval / 20)],
            @"txPower":txPower,
            @"advTime":advTime,
        };
    }else if ([cmd isEqualToString:@"46"]) {
        //读取活跃通道触发前广播开关
        operationID = mk_bxb_taskReadStayAdvertisingBeforeTriggeredOperation;
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
    }else if ([cmd isEqualToString:@"47"]) {
        //读取触发提醒模式
        operationID = mk_bxb_taskReadAlarmNotificationTypeOperation;
        NSString *alarmNotiType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"alarmNotificationType":alarmNotiType,
        };
    }else if ([cmd isEqualToString:@"53"]) {
        //设置活跃通道
        operationID = mk_bxb_taskConfigActiveChannelOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"54"]) {
        //设置活跃通道广播参数
        operationID = mk_bxb_taskConfigTriggerChannelAdvParamsOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"55"]) {
        //设置活跃通道触发广播参数
        operationID = mk_bxb_taskConfigChannelTriggerParamsOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"56"]) {
        //设置活跃通道触发前广播开关
        operationID = mk_bxb_taskConfigStayAdvertisingBeforeTriggeredOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"57"]) {
        //设置触发提醒模式
        operationID = mk_bxb_taskConfigAlarmNotificationTypeOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"61"]) {
        //设置远程消警
        operationID = mk_bxb_taskConfigDismissAlarmOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"63"]) {
        //读取LED消警参数
        operationID = mk_bxb_taskReadDismissAlarmLEDNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"64"]) {
        //读取马达消警参数
        operationID = mk_bxb_taskReadDismissAlarmVibrationNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"65"]) {
        //读取蜂鸣器消警参数
        operationID = mk_bxb_taskReadDismissAlarmBuzzerNotiParamsOperation;
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSInteger interval = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"time":time,
            @"interval":[NSString stringWithFormat:@"%ld",(long)(interval / 100)],
        };
    }else if ([cmd isEqualToString:@"66"]) {
        //读取消警提醒模式
        operationID = mk_bxb_taskReadDismissAlarmNotificationTypeOperation;
        NSString *alarmNotiType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"type":alarmNotiType,
        };
    }else if ([cmd isEqualToString:@"67"]) {
        //删除单击通道触发记录
        operationID = mk_bxb_taskClearSinglePressEventDataOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"68"]) {
        //删除双击通道触发记录
        operationID = mk_bxb_taskClearDoublePressEventDataOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"69"]) {
        //删除长按通道触发记录
        operationID = mk_bxb_taskClearLongPressEventDataOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"6a"]) {
        //读取电池电压
        operationID = mk_bxb_taskReadBatteryVoltageOperation;
        NSString *voltage = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"voltage":voltage,
        };
    }else if ([cmd isEqualToString:@"6b"]) {
        //读取设备时间
        operationID = mk_bxb_taskReadDeviceTimeOperation;
        NSString *timestamp = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"timestamp":timestamp};
    }else if ([cmd isEqualToString:@"6f"]) {
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
    }else if ([cmd isEqualToString:@"73"]) {
        //设置远程LED消警参数
        operationID = mk_bxb_taskConfigDismissAlarmLEDNotiParamsOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"74"]) {
        //设置远程马达消警参数
        operationID = mk_bxb_taskConfigDismissAlarmVibrationNotiParamsOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"75"]) {
        //设置远程蜂鸣器消警参数
        operationID = mk_bxb_taskConfigDismissAlarmBuzzerNotiParamsOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"76"]) {
        //设置消警提醒模式
        operationID = mk_bxb_taskConfigDismissAlarmNotificationTypeOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"7b"]) {
        //设置设备时间
        operationID = mk_bxb_taskConfigDeviceTimeOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"80"]) {
        //读取deviceID
        operationID = mk_bxb_taskReadDeviceIDOperation;
        resultDic = @{
            @"deviceID":content,
        };
    }else if ([cmd isEqualToString:@"81"]) {
        //读取设备名称
        operationID = mk_bxb_taskReadDeviceNameOperation;
        NSString *deviceName = [[NSString alloc] initWithData:[readData subdataWithRange:NSMakeRange(4, readData.length - 4)] encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
    }else if ([cmd isEqualToString:@"82"]) {
        //读取单击触发次数
        operationID = mk_bxb_taskReadSinglePressEventCountOperation;
        NSString *count = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"count":count,
        };
    }else if ([cmd isEqualToString:@"83"]) {
        //读取双击触发次数
        operationID = mk_bxb_taskReadDoublePressEventCountOperation;
        NSString *count = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"count":count,
        };
    }else if ([cmd isEqualToString:@"84"]) {
        //读取长按触发次数
        operationID = mk_bxb_taskReadLongPressEventCountOperation;
        NSString *count = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"count":count,
        };
    }else if ([cmd isEqualToString:@"85"]) {
        //验证密码
        operationID = mk_bxb_connectPasswordOperation;
        
        resultDic = @{
            @"state":content,
        };
    }else if ([cmd isEqualToString:@"90"]) {
        //设置deviceID
        operationID = mk_bxb_taskConfigDeviceIDOperation;
        resultDic = @{@"success":@(YES)};
    }else if ([cmd isEqualToString:@"91"]) {
        //设置设备名称
        operationID = mk_bxb_taskConfigDeviceNameOperation;
        resultDic = @{@"success":@(YES)};
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
