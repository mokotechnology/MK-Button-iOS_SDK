//
//  MKBXBAlarmNotiTypeController.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKBXBAlarmNotiTypeControllerType) {
    MKBXBAlarmNotiTypeControllerType_single,
    MKBXBAlarmNotiTypeControllerType_double,
    MKBXBAlarmNotiTypeControllerType_long,
    MKBXBAlarmNotiTypeControllerType_abnormal,
};

@interface MKBXBAlarmNotiTypeController : MKBaseViewController

@property (nonatomic, assign)MKBXBAlarmNotiTypeControllerType pageType;

@end

NS_ASSUME_NONNULL_END
