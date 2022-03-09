//
//  CBPeripheral+MKBXBAdd.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKBXBAdd.h"

#import <objc/runtime.h>

static const char *bxb_customKey = "bxb_customKey";
static const char *bxb_disconnectTypeKey = "bxb_disconnectTypeKey";
static const char *bxb_singleAlarmDataKey = "bxb_singleAlarmDataKey";
static const char *bxb_doubleAlarmDataKey = "bxb_doubleAlarmDataKey";
static const char *bxb_longAlarmDataKey = "bxb_longAlarmDataKey";
static const char *bxb_threeAxisDataKey = "bxb_threeAxisDataKey";
static const char *bxb_passwordKey = "bxb_passwordKey";

static const char *bxb_manufacturerKey = "bxb_manufacturerKey";
static const char *bxb_deviceModelKey = "bxb_deviceModelKey";
static const char *bxb_productionDateKey = "bxb_productionDateKey";
static const char *bxb_hardwareKey = "bxb_hardwareKey";
static const char *bxb_softwareKey = "bxb_softwareKey";
static const char *bxb_firmwareKey = "bxb_firmwareKey";

static const char *bxb_customSuccessKey = "bxb_customSuccessKey";
static const char *bxb_disconnectTypeSuccessKey = "bxb_disconnectTypeSuccessKey";
static const char *bxb_passwordSuccessKey = "bxb_passwordSuccessKey";

@implementation CBPeripheral (MKBXBAdd)

- (void)bxb_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &bxb_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A25"]]) {
                objc_setAssociatedObject(self, &bxb_productionDateKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &bxb_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &bxb_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &bxb_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &bxb_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &bxb_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &bxb_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &bxb_singleAlarmDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &bxb_doubleAlarmDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &bxb_longAlarmDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA06"]]) {
                objc_setAssociatedObject(self, &bxb_threeAxisDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA07"]]) {
                objc_setAssociatedObject(self, &bxb_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }
        }
        return;
    }
}

- (void)bxb_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]){
        objc_setAssociatedObject(self, &bxb_customSuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]){
        objc_setAssociatedObject(self, &bxb_disconnectTypeSuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA07"]]) {
        objc_setAssociatedObject(self, &bxb_passwordSuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)bxb_connectSuccess {
    if (![objc_getAssociatedObject(self, &bxb_disconnectTypeSuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bxb_customSuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bxb_passwordSuccessKey) boolValue]) {
        return NO;
    }
    if (![self bxb_customServiceSuccess] || ![self bxb_deviceInfoServiceSuccess]) {
        return NO;
    }
    return YES;
}

- (void)bxb_setNil {
    objc_setAssociatedObject(self, &bxb_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_productionDateKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bxb_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_singleAlarmDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_doubleAlarmDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_longAlarmDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_threeAxisDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bxb_customSuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_disconnectTypeSuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_passwordSuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)bxb_manufacturer {
    return objc_getAssociatedObject(self, &bxb_manufacturerKey);
}

- (CBCharacteristic *)bxb_productionDate {
    return objc_getAssociatedObject(self, &bxb_productionDateKey);
}

- (CBCharacteristic *)bxb_deviceModel {
    return objc_getAssociatedObject(self, &bxb_deviceModelKey);
}

- (CBCharacteristic *)bxb_hardware {
    return objc_getAssociatedObject(self, &bxb_hardwareKey);
}

- (CBCharacteristic *)bxb_software {
    return objc_getAssociatedObject(self, &bxb_softwareKey);
}

- (CBCharacteristic *)bxb_firmware {
    return objc_getAssociatedObject(self, &bxb_firmwareKey);
}

- (CBCharacteristic *)bxb_custom {
    return objc_getAssociatedObject(self, &bxb_customKey);
}

- (CBCharacteristic *)bxb_disconnectType {
    return objc_getAssociatedObject(self, &bxb_disconnectTypeKey);
}

- (CBCharacteristic *)bxb_singleAlarmData {
    return objc_getAssociatedObject(self, &bxb_singleAlarmDataKey);
}

- (CBCharacteristic *)bxb_doubleAlarmData {
    return objc_getAssociatedObject(self, &bxb_doubleAlarmDataKey);
}

- (CBCharacteristic *)bxb_longAlarmData {
    return objc_getAssociatedObject(self, &bxb_longAlarmDataKey);
}

- (CBCharacteristic *)bxb_threeAxisData {
    return objc_getAssociatedObject(self, &bxb_threeAxisDataKey);
}

- (CBCharacteristic *)bxb_password {
    return objc_getAssociatedObject(self, &bxb_passwordKey);
}

#pragma mark - private method
- (BOOL)bxb_customServiceSuccess {
    if (!self.bxb_custom || !self.bxb_disconnectType || !self.bxb_singleAlarmData || !self.bxb_doubleAlarmData || !self.bxb_longAlarmData || !self.bxb_threeAxisData || !self.bxb_password) {
        return NO;
    }
    return YES;
}

- (BOOL)bxb_deviceInfoServiceSuccess {
    if (!self.bxb_manufacturer || !self.bxb_productionDate
        || !self.bxb_deviceModel || !self.bxb_hardware
        || !self.bxb_software || !self.bxb_firmware) {
        return NO;
    }
    return YES;
}

@end
