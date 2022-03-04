//
//  MKBXBAlarmSyncTimeView.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKBXBAlarmSyncTimeViewDelegate <NSObject>

- (void)bxb_alarmSyncTimeButtonPressed;

@end

@interface MKBXBAlarmSyncTimeView : UIView

@property (nonatomic, weak)id <MKBXBAlarmSyncTimeViewDelegate>delegate;

- (void)updateTimestamp:(NSString *)timestamp;

@end

NS_ASSUME_NONNULL_END
