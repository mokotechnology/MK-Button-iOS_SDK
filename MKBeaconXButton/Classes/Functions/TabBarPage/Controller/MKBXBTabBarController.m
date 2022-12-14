//
//  MKBXBTabBarController.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBTabBarController.h"

#import "MKMacroDefines.h"
#import "MKBaseNavigationController.h"

#import "MKAlertView.h"

#import "MKBLEBaseLogManager.h"

#import "MKBXBCentralManager.h"

#import "MKBXBAlarmController.h"
#import "MKBXBSettingController.h"
#import "MKBXBDeviceController.h"

@interface MKBXBTabBarController ()

/// 当触发
/// 01:表示连接成功后，1分钟内没有通过密码验证（未输入密码，或者连续输入密码错误）认为超时，返回结果， 然后断开连接
/// 02:修改密码成功后，返回结果，断开连接
/// 03:恢复出厂设置
/// 04:关机

@property (nonatomic, assign)BOOL disconnectType;

@end

@implementation MKBXBTabBarController

- (void)dealloc {
    NSLog(@"MKBXBTabBarController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![[self.navigationController viewControllers] containsObject:self]){
        [[MKBXBCentralManager shared] disconnect];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubPages];
    [self addNotifications];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoScanPage)
                                                 name:@"mk_bxb_popToRootViewControllerNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dfuUpdateComplete)
                                                 name:@"mk_bxb_centralDeallocNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(centralManagerStateChanged)
                                                 name:mk_bxb_centralManagerStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:mk_bxb_deviceDisconnectTypeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_bxb_peripheralConnectStateChangedNotification
                                               object:nil];
}

#pragma mark - notes
- (void)gotoScanPage {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_bxb_needResetScanDelegate:)]) {
            [self.delegate mk_bxb_needResetScanDelegate:NO];
        }
    }];
}

- (void)dfuUpdateComplete {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_bxb_needResetScanDelegate:)]) {
            [self.delegate mk_bxb_needResetScanDelegate:YES];
        }
    }];
}

- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    //02:修改密码成功后，返回结果，断开连接
    //03:恢复出厂设置
    //04:关机
    self.disconnectType = YES;
    if ([type isEqualToString:@"02"]) {
        [self showAlertWithMsg:@"Modify password success! Please reconnect the Device." title:@""];
        return;
    }
    if ([type isEqualToString:@"03"]) {
        [self showAlertWithMsg:@"Factory reset successfully!Please reconnect the device." title:@"Factory Reset"];
        return;
    }
    if ([type isEqualToString:@"04"]) {
        [self gotoScanPage];
//        [self showAlertWithMsg:@"Beacon is disconnected." title:@"Reset success!"];
        return;
    }
}

- (void)centralManagerStateChanged{
    if (self.disconnectType) {
        return;
    }
    if ([MKBXBCentralManager shared].centralStatus != mk_bxb_centralManagerStatusEnable) {
        [self showAlertWithMsg:@"The current system of bluetooth is not available!" title:@"Dismiss"];
    }
}

- (void)deviceConnectStateChanged {
     if (self.disconnectType) {
        return;
    }
    [self showAlertWithMsg:@"The device is disconnected." title:@"Dismiss"];
    return;
}

#pragma mark - private method
- (void)showAlertWithMsg:(NSString *)msg title:(NSString *)title{
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_bxb_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    
    @weakify(self);
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        [self gotoScanPage];
    }];
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:title message:msg notificationName:@"mk_bxb_needDismissAlert"];
}

- (void)loadSubPages {
    MKBXBAlarmController *alarmPage = [[MKBXBAlarmController alloc] init];
    alarmPage.tabBarItem.title = @"ALARM";
    alarmPage.tabBarItem.image = LOADICON(@"MKBeaconXButton", @"MKBXBTabBarController", @"bxb_slotTabBarItemUnselected.png");
    alarmPage.tabBarItem.selectedImage = LOADICON(@"MKBeaconXButton", @"MKBXBTabBarController", @"bxb_slotTabBarItemSelected.png");
    MKBaseNavigationController *alarmNav = [[MKBaseNavigationController alloc] initWithRootViewController:alarmPage];

    MKBXBSettingController *settingPage = [[MKBXBSettingController alloc] init];
    settingPage.tabBarItem.title = @"SETTING";
    settingPage.tabBarItem.image = LOADICON(@"MKBeaconXButton", @"MKBXBTabBarController", @"bxb_settingTabBarItemUnselected.png");
    settingPage.tabBarItem.selectedImage = LOADICON(@"MKBeaconXButton", @"MKBXBTabBarController", @"bxb_settingTabBarItemSelected.png");
    MKBaseNavigationController *settingNav = [[MKBaseNavigationController alloc] initWithRootViewController:settingPage];

    MKBXBDeviceController *devicePage = [[MKBXBDeviceController alloc] init];
    devicePage.tabBarItem.title = @"DEVICE";
    devicePage.tabBarItem.image = LOADICON(@"MKBeaconXButton", @"MKBXBTabBarController", @"bxb_deviceTabBarItemUnselected.png");
    devicePage.tabBarItem.selectedImage = LOADICON(@"MKBeaconXButton", @"MKBXBTabBarController", @"bxb_deviceTabBarItemSelected.png");
    MKBaseNavigationController *deviceNav = [[MKBaseNavigationController alloc] initWithRootViewController:devicePage];
    
    self.viewControllers = @[alarmNav,settingNav,deviceNav];
}

@end
