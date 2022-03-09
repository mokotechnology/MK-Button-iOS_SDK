//
//  MKBXBInterface+MKBXBConfig.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBInterface (MKBXBConfig)

/**
 Setting the sampling rate, scale and sensitivity of the 3-axis accelerometer sensor

 @param dataRate sampling rate
 @param fullScale scale
 @param motionThreshold 1~2048.(fullScale==mk_bxb_threeAxisDataAG0--->x1mg)(fullScale==mk_bxb_threeAxisDataAG1--->x2mg)(fullScale==mk_bxb_threeAxisDataAG2--->x4mg)(fullScale==mk_bxb_threeAxisDataAG3--->x12mg)
 @param sucBlock Success callback
 @param failedBlock Failure callback
 */
+ (void)bxb_configThreeAxisDataParams:(mk_bxb_threeAxisDataRate)dataRate
                            fullScale:(mk_bxb_threeAxisDataAG)fullScale
                      motionThreshold:(NSInteger)motionThreshold
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connectable state of the device.
/// @param connectable connectable
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configConnectable:(BOOL)connectable
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether the device has enabled password verification when connecting. When the device has disabled password verification, no password is required to connect to the device, otherwise a connection password is required.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configPasswordVerification:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the current connection password of the device.
/// @param password 1~16 ascii characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configConnectPassword:(NSString *)password
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Effective click interval.
/// @param interval 5~15.(unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configEffectiveClickInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Power Off.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_powerOffWithSucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_factoryResetWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Turn off Device by button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configTurnOffDeviceByButtonStatus:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Scan response packet.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configScanResponsePacket:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset Device by button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configResetDeviceByButtonStatus:(BOOL)isOn
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the channel broadcast parameters that trigger the alarm function.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configTriggerChannelAdvParams:(id <MKBXBTriggerChannelAdvParamsProtocol>)protocol
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the trigger broadcast parameters of the channel.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configChannelTriggerParams:(id <MKBXBChannelTriggerParamsProtocol>)protocol
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Stay advertising before triggered.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configStayAdvertisingBeforeTriggered:(MKBXBChannelAlarmType)channelType
                                            isOn:(BOOL)isOn
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm notification type.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configAlarmNotificationType:(MKBXBChannelAlarmType)channelType
                           reminderType:(mk_bxb_reminderType)reminderType
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Abnormal inactivity time.
/// @param time 1s~65535s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configAbnormalInactivityTime:(NSInteger)time
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Power saving mode.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configPowerSavingMode:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// After device keep static for time, it will stop advertising and disable alarm mode to enter into power saving mode until device moves.
/// @param time 1s~65535s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configStaticTriggerTime:(NSInteger)time
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger LED reminder parameters.
/// @param channelType channelType
/// @param blinkingTime Blinking time.1 ~ 6000(Unit:100ms)
/// @param blinkingInterval Blinking interval.1 ~ 100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configAlarmLEDNotiParams:(MKBXBChannelAlarmType)channelType
                        blinkingTime:(NSInteger)blinkingTime
                    blinkingInterval:(NSInteger)blinkingInterval
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger Vibration reminder parameters.
/// @param channelType channelType
/// @param vibratingTime Vibrating time.1 ~ 6000(Unit:100ms)
/// @param vibratingInterval Vibrating interval.1 ~ 100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configAlarmVibrationNotiParams:(MKBXBChannelAlarmType)channelType
                             vibratingTime:(NSInteger)vibratingTime
                         vibratingInterval:(NSInteger)vibratingInterval
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger Buzzer reminder parameters.
/// @param channelType channelType
/// @param ringingTime Ringing time.1 ~ 6000(Unit:100ms)
/// @param ringingInterval Ringing interval.1 ~ 100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configAlarmBuzzerNotiParams:(MKBXBChannelAlarmType)channelType
                            ringingTime:(NSInteger)ringingTime
                        ringingInterval:(NSInteger)ringingInterval
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Remote LED reminder parameters.
/// @param blinkingTime Blinking time.1 ~ 6000(Unit:100ms)
/// @param blinkingInterval Blinking interval.1 ~ 100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configRemoteReminderLEDNotiParams:(NSInteger)blinkingTime
                             blinkingInterval:(NSInteger)blinkingInterval
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Remote Vibration reminder parameters.
/// @param vibratingTime Vibrating time.1 ~ 6000(Unit:100ms)
/// @param vibratingInterval Vibrating interval.1 ~ 100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configRemoteReminderVibrationNotiParams:(NSInteger)vibratingTime
                                  vibratingInterval:(NSInteger)vibratingInterval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Remote Buzzer reminder parameters.
/// @param ringingTime Ringing time.1 ~ 6000(Unit:100ms)
/// @param ringingInterval Ringing interval.1 ~ 100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configRemoteReminderBuzzerNotiParams:(NSInteger)ringingTime
                                 ringingInterval:(NSInteger)ringingInterval
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss alarm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss alarm by button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmByButton:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LED dismissal alarm parameter.
/// @param time 1~6000 (unit:100ms)
/// @param interval 1~100(unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmLEDNotiParams:(NSInteger)time
                                   interval:(NSInteger)interval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Vibration dismissal alarm parameter.
/// @param time 1~6000 (unit:100ms)
/// @param interval 1~100(unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmVibrationNotiParams:(NSInteger)time
                                         interval:(NSInteger)interval
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Buzzer dismissal alarm parameter.
/// @param time 1~6000 (unit:100ms)
/// @param interval 1~100(unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmBuzzerNotiParams:(NSInteger)time
                                      interval:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss alarm notification type.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmNotificationType:(mk_bxb_reminderType)type
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Delete the trigger record of the single press event.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_clearSinglePressEventDataWithSucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Delete the trigger record of the double press event.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_clearDoublePressEventDataWithSucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Delete the trigger record of the long press event.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_clearLongPressEventDataWithSucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Device Time.
/// @param timestamp Timestamp
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDeviceTime:(long long)timestamp
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the device' ID.
/// @param deviceID 1 ~ 6 Bytes.(HEX)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDeviceID:(NSString *)deviceID
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast name of the device.
/// @param deviceName 1~10 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDeviceName:(NSString *)deviceName
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;














#pragma mark - FEE3

@end

NS_ASSUME_NONNULL_END
