//
//  MKBXBDismissConfigModel.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/21.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBDismissConfigModel : NSObject

/*
 0:Silent
 1:LED
 2:Vibration
 3:Buzzer
 4:LED+Vibration
 5:LED+Buzzer
 */
@property (nonatomic, assign)NSInteger dismissAlarmNotiType;

#pragma mark - LED notification
@property (nonatomic, copy)NSString *blinkingTime;

@property (nonatomic, copy)NSString *blinkingInterval;

#pragma mark - Vibration notification
@property (nonatomic, copy)NSString *vibratingTime;

@property (nonatomic, copy)NSString *vibratingInterval;

#pragma mark - Buzzer notification
@property (nonatomic, copy)NSString *ringingTime;

@property (nonatomic, copy)NSString *ringingInterval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
