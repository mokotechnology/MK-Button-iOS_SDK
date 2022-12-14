#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MKBXBApplicationModule.h"
#import "CTMediator+MKBXBAdd.h"
#import "MKBXBConnectManager.h"
#import "MKBXBDeviceIDCell.h"
#import "MKBXBNotificationTypePickerView.h"
#import "MKBXBAboutController.h"
#import "MKBXBAccelerationController.h"
#import "MKBXBAccelerationModel.h"
#import "MKBXBAccelerationHeaderView.h"
#import "MKBXBAlarmDataExportController.h"
#import "MKBXBAlarmDataExportButton.h"
#import "MKBXBAlarmEventController.h"
#import "MKBXBAlarmEventDataModel.h"
#import "MKBXBAlarmEventCountCell.h"
#import "MKBXBAlarmSyncTimeView.h"
#import "MKBXBAlarmModeConfigController.h"
#import "MKBXBAlarmModeConfigModel.h"
#import "MKBXBAbnormalInactivityTimeCell.h"
#import "MKBXBTxPowerCell.h"
#import "MKBXBAlarmNotiTypeController.h"
#import "MKBXBAlarmNotiTypeModel.h"
#import "MKBXBAlarmController.h"
#import "MKBXBAlarmPageModel.h"
#import "MKBXBDeviceInfoController.h"
#import "MKBXBDeviceInfoModel.h"
#import "MKBXBDeviceController.h"
#import "MKBXBDevicePageModel.h"
#import "MKBXBDismissConfigController.h"
#import "MKBXBDismissConfigModel.h"
#import "MKBXBPowerSaveController.h"
#import "MKBXBPowerSaveModel.h"
#import "MKBXBPowerSaveTriggerTimeCell.h"
#import "MKBXBQuickSwitchController.h"
#import "MKBXBQuickSwitchModel.h"
#import "MKBXBRemoteReminderController.h"
#import "MKBXBRemoteReminderModel.h"
#import "MKBXBRemoteReminderCell.h"
#import "MKBXBScanPageAdopter.h"
#import "MKBXBScanController.h"
#import "MKBXBScanDataModel.h"
#import "MKBXBScanAdvCell.h"
#import "MKBXBScanDeviceDataCell.h"
#import "MKBXBScanDeviceInfoCell.h"
#import "MKBXBSettingController.h"
#import "MKBXBSettingPageModel.h"
#import "MKBXBTabBarController.h"
#import "MKBXBUpdateController.h"
#import "MKBXBDFUModule.h"
#import "CBPeripheral+MKBXBAdd.h"
#import "MKBXBAdopter.h"
#import "MKBXBBaseAdvModel.h"
#import "MKBXBCentralManager.h"
#import "MKBXBInterface+MKBXBConfig.h"
#import "MKBXBInterface.h"
#import "MKBXBOperation.h"
#import "MKBXBOperationID.h"
#import "MKBXBPeripheral.h"
#import "MKBXBSDK.h"
#import "MKBXBSDKNormalDefines.h"
#import "MKBXBTaskAdopter.h"
#import "Target_BXB_Module.h"

FOUNDATION_EXPORT double MKBeaconXButtonVersionNumber;
FOUNDATION_EXPORT const unsigned char MKBeaconXButtonVersionString[];

