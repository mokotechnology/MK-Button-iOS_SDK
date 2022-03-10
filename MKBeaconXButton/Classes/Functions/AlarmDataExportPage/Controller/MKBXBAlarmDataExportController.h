//
//  MKBXBAlarmDataExportController.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/3/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKBXBAlarmDataExportControllerType) {
    MKBXBAlarmDataExportControllerType_single,
    MKBXBAlarmDataExportControllerType_double,
    MKBXBAlarmDataExportControllerType_long,
};

@interface MKBXBAlarmDataExportController : MKBaseViewController

@property (nonatomic, assign)MKBXBAlarmDataExportControllerType pageType;

@end

NS_ASSUME_NONNULL_END
