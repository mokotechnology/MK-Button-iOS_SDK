//
//  MKBXBScanDataModel.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKBXBScanDataModel : NSObject

/// 强业务相关，设备信息帧的广播数组，广播包(4种广播帧)、回应包广播帧会被添加到对应的设备信息帧的广播数组里面来
@property (nonatomic, strong)NSMutableArray *advertiseList;

@property (nonatomic, copy)NSString *rssi;

@property (nonatomic, assign) BOOL connectEnable;

/**
 Scanned device identifier
 */
@property (nonatomic, copy)NSString *identifier;
/**
 Scanned devices
 */
@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *battery;

@property (nonatomic, copy)NSString *txPower;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *deviceID;

/// 用于记录本次扫到该设备距离上次扫到该设备的时间差，单位ms.
@property (nonatomic, copy)NSString *displayTime;

/**
 上一次扫描到的时间
 */
@property (nonatomic, assign)NSTimeInterval lastScanDate;

/// 是否需要密码连接
@property (nonatomic, assign)BOOL needPassword;

@end

NS_ASSUME_NONNULL_END
