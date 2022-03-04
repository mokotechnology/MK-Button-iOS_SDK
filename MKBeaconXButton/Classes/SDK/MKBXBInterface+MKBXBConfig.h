//
//  MKBXBInterface+MKBXBConfig.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBInterface.h"

#import "MKBXBSDKNormalDefines.h"

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

/// Effective click interval.
/// @param interval 5~15.(unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configEffectiveClickInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Activate the channel type that triggers the alarm function.
/// @param alarmType alarmType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configActiveChannel:(MKBXBChannelAlarmType)alarmType
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
+ (void)bxb_configStayAdvertisingBeforeTriggered:(BOOL)isOn
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm notification type.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configAlarmNotificationType:(mk_bxb_reminderType)type
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss alarm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bxb_configDismissAlarmWithSucBlock:(void (^)(void))sucBlock
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
/// @param deviceID 1 ~ 8 Bytes.(HEX)
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
