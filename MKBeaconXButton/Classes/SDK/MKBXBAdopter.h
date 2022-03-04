//
//  MKBXBAdopter.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBXBSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBAdopter : NSObject

+ (BOOL)validTriggerChannelAdvParamsProtocol:(id <MKBXBTriggerChannelAdvParamsProtocol>)protocol;

+ (NSString *)parseTriggerChannelAdvParamsProtocol:(id <MKBXBTriggerChannelAdvParamsProtocol>)protocol;

+ (BOOL)validChannelTriggerParamsProtocol:(id <MKBXBChannelTriggerParamsProtocol>)protocol;

+ (NSString *)parseChannelTriggerParamsProtocol:(id <MKBXBChannelTriggerParamsProtocol>)protocol;

+ (NSString *)fetchTxPower:(mk_bxb_txPower)txPower;

+ (NSString *)fetchTxPowerValueString:(NSString *)content;

+ (NSString *)fetchReminderTypeString:(mk_bxb_reminderType)type;

+ (NSString *)fetchThreeAxisDataRate:(mk_bxb_threeAxisDataRate)dataRate;

+ (NSString *)fetchThreeAxisDataAG:(mk_bxb_threeAxisDataAG)ag;

@end

NS_ASSUME_NONNULL_END
