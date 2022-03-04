//
//  CBPeripheral+MKBXBAdd.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKBXBAdd.h"

#import <objc/runtime.h>

static const char *bxb_customWriteKey = "bxb_customWriteKey";
static const char *bxb_customNotifyKey = "bxb_customNotifyKey";
static const char *bxb_alarmWriteKey = "bxb_alarmWriteKey";
static const char *bxb_alarmNotifyKey = "bxb_alarmNotifyKey";

static const char *bxb_manufacturerKey = "bxb_manufacturerKey";
static const char *bxb_deviceModelKey = "bxb_deviceModelKey";
static const char *bxb_productionDateKey = "bxb_productionDateKey";
static const char *bxb_hardwareKey = "bxb_hardwareKey";
static const char *bxb_softwareKey = "bxb_softwareKey";
static const char *bxb_firmwareKey = "bxb_firmwareKey";

static const char *bxb_customNotifySuccessKey = "bxb_customNotifySuccessKey";
static const char *bxb_alarmSuccessKey = "bxb_alarmSuccessKey";

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
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FEE0"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FEE1"]]) {
                objc_setAssociatedObject(self, &bxb_customWriteKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FEE2"]]) {
                objc_setAssociatedObject(self, &bxb_customNotifyKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FEE3"]]) {
                objc_setAssociatedObject(self, &bxb_alarmWriteKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FEE4"]]) {
                objc_setAssociatedObject(self, &bxb_alarmNotifyKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }
        }
        return;
    }
}

- (void)bxb_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FEE2"]]){
        objc_setAssociatedObject(self, &bxb_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FEE4"]]) {
        objc_setAssociatedObject(self, &bxb_alarmSuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)bxb_connectSuccess {
    if (![objc_getAssociatedObject(self, &bxb_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bxb_alarmSuccessKey) boolValue]) {
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
    
    objc_setAssociatedObject(self, &bxb_customWriteKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_customNotifyKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_alarmWriteKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_alarmNotifyKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bxb_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bxb_alarmSuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (CBCharacteristic *)bxb_customWrite {
    return objc_getAssociatedObject(self, &bxb_customWriteKey);
}

- (CBCharacteristic *)bxb_customNotify {
    return objc_getAssociatedObject(self, &bxb_customNotifyKey);
}

- (CBCharacteristic *)bxb_alarmWrite {
    return objc_getAssociatedObject(self, &bxb_alarmWriteKey);
}

- (CBCharacteristic *)bxb_alarmNotify {
    return objc_getAssociatedObject(self, &bxb_alarmNotifyKey);
}

#pragma mark - private method
- (BOOL)bxb_customServiceSuccess {
    if (!self.bxb_customWrite || !self.bxb_customNotify || !self.bxb_alarmWrite || !self.bxb_alarmNotify) {
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
