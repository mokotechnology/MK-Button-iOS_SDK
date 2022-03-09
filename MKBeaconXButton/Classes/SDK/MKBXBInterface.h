//
//  MKBXBInterface.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBXBSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Reading the production date of device
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)bxb_readProductionDateWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark - custom

/// Read the mac address of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Read the sampling rate, scale and sensitivity of the 3-axis accelerometer sensor
 
 @{
 @"samplingRate":The 3-axis accelerometer sampling rate is 5 levels in total, 00--1hz，01--10hz，02--25hz，03--50hz，04--100hz
 @"fullScale": The 3-axis accelerometer scale is 4 levels, which are 00--±2g；01--±4g；02--±8g；03--±16g
 @"threshold": Motion threshold.If the Full-scale is ±2g,unit is 1mg.If the Full-scale is ±4g,unit is 2mg.If the Full-scale is ±8g,unit is 4mg.If the Full-scale is ±16g,unit is 12mg.
 }

 @param sucBlock Success callback
 @param failedBlock Failure callback
 */
+ (void)bxb_readThreeAxisDataParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the connectable status of the device.
/*
 @{
 @"connectable":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readConnectableWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether the device has enabled password verification when connecting. When the device has disabled password verification, no password is required to connect to the device, otherwise a connection password is required.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readPasswordVerificationWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current connection password of the device.
/*
 @{
 @"password":@"xxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readConnectPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Effective click interval.
/*
 @{
 @"interval":@"6",          //unit:100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readEffectiveClickIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Turn off Device by button.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readTurnOffDeviceByButtonStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Scan response packet.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readScanResponsePacketWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset Device by button.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readResetDeviceByButtonStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast enable condition of each channel.
/*
 @{
     @"singlePressMode":@(YES),                      //The state of single press mode.
     @"doublePressMode":@(YES),                      //The state of double press mode.
     @"longPressMode":@(YES),                        //The state of long press mode.
     @"abnormalInactivityMode":@(NO),               //The state of abnormal inactivity mode.
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readTriggerChannelStateWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the channel broadcast parameters that trigger the alarm function.
/*
 @{
    @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
     @"isOn":@(YES),                //SLOT advertisement is on.
     @"rssi":@"-90",                //Ranging data
     @"advInterval":@"30",          //Adv Interval
     @"txPower":@"-8dBm",           //Tx Power
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readTriggerChannelAdvParams:(MKBXBChannelAlarmType)channelType
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the trigger broadcast parameters of the channel.
/*
 @{
 @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
     @"alarm":@(YES),           //Whether to enable trigger function.
    @"rssi":@"-90",                //Ranging data
    @"advInterval":@"30",          //Adv Interval
    @"txPower":@"-8dBm",           //Tx Power
     @"advTime":@"55",              //broadcast time after trigger.
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readChannelTriggerParams:(MKBXBChannelAlarmType)channelType
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Stay advertising before triggered.
/*
 @{
 @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
 @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readStayAdvertisingBeforeTriggered:(MKBXBChannelAlarmType)channelType
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm notification type.
/*
 @{
 @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
    @"alarmNotificationType":@"0"           //0:Silent  1:LED 2:Vibration 3:Buzzer 4:LED+Vibration  5:LED+Buzzer
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readAlarmNotificationType:(MKBXBChannelAlarmType)channelType
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Abnormal inactivity time.
/*
 @{
 @"time":time
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readAbnormalInactivityTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Power saving mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readPowerSavingModeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// After device keep static for time, it will stop advertising and disable alarm mode to enter into power saving mode until device moves.
/*
 @{
 @"time":time
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readStaticTriggerTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger LED reminder parameters.
/*
 @{
 @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param channelType channelType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readAlarmLEDNotiParams:(MKBXBChannelAlarmType)channelType
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger Vibration reminder parameters.
/*
 @{
 @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param channelType channelType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readAlarmVibrationNotiParams:(MKBXBChannelAlarmType)channelType
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Buzzer Vibration reminder parameters.
/*
 @{
 @"channelType":@"00",           //@"00":Single  @"01":Double   @"02":Long  @"03":Abnormal Inactivity.
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param channelType channelType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readAlarmBuzzerNotiParams:(MKBXBChannelAlarmType)channelType
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Remote LED reminder parameters.
/*
 @{
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readRemoteReminderLEDNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Remote Vibration reminder parameters.
/*
 @{
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readRemoteReminderVibrationNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Remote Buzzer reminder parameters.
/*
 @{
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readRemoteReminderBuzzerNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss alarm by button.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDismissAlarmByButtonWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LED dismissal alarm parameter.
/*
 @{
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDismissAlarmLEDNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Vibration dismissal alarm parameter.
/*
 @{
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDismissAlarmVibrationNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Buzzer dismissal alarm parameter.
/*
 @{
 @"time":@"10",         //x100ms
 @"interval":@"5",      //x100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDismissAlarmBuzzerNotiParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss alarm notification type.
/*
 @{
    @"type":@"0"           //0:Silent  1:LED 2:Vibration 3:Buzzer 4:LED+Vibration  5:LED+Buzzer
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDismissAlarmNotificationTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Voltage of the device.
/*
 @{
 @"voltage":@"3330",        //mV
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device current time.
/*
 @{
 @"timestamp":@"1646797042924",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDeviceTimeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read sensor status.
/*
 @{
     @"threeAxis":@(YES),           //Whether the device has a 3-axis accelerometer.
     @"htSensor":@(YES),            //Whether the device has a temperature and humidity sensor.
     @"lightSensor":@(YES)          //Whether the device has a light sensor.
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readSensorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the device' ID.
/*
 @{
 @"deviceID":@"112233"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDeviceIDWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast name of the device.
/*
 @"deviceName":@"MK Button"
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the count of the single press event.
/*
 @{
 @"count":@"0"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readSinglePressEventCountWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the count of the double press event.
/*
 @{
 @"count":@"0"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDoublePressEventCountWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the count of the long press event.
/*
 @{
 @"count":@"0"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readLongPressEventCountWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Device Type.
/*
 @{
 @"deviceType":@"00"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_readDeviceTypeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
