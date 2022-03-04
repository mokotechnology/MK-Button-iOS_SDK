//
//  MKBXBAlarmModeConfigController.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKBXBAlarmModeConfigControllerType) {
    MKBXBAlarmModeConfigControllerType_single,
    MKBXBAlarmModeConfigControllerType_double,
    MKBXBAlarmModeConfigControllerType_long,
    MKBXBAlarmModeConfigControllerType_abnormal,
};

@interface MKBXBAlarmModeConfigController : MKBaseViewController

@property (nonatomic, assign)MKBXBAlarmModeConfigControllerType pageType;

@end

NS_ASSUME_NONNULL_END
