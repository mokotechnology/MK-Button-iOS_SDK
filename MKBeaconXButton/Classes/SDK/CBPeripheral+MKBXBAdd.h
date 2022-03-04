//
//  CBPeripheral+MKBXBAdd.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKBXBAdd)

#pragma mark - 系统信息下面的特征
/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_productionDate;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_firmware;

#pragma mark - Custom Characteristic
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_customWrite;
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_customNotify;
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_alarmWrite;
@property (nonatomic, strong, readonly)CBCharacteristic *bxb_alarmNotify;

- (void)bxb_updateCharacterWithService:(CBService *)service;

- (void)bxb_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)bxb_connectSuccess;

- (void)bxb_setNil;

@end

NS_ASSUME_NONNULL_END
