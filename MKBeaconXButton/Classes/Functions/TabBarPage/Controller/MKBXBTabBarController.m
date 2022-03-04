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

#import "MKBXBCentralManager.h"

#import "MKBXBAlarmController.h"
#import "MKBXBSettingController.h"
#import "MKBXBDeviceController.h"

@interface MKBXBTabBarController ()

@end

@implementation MKBXBTabBarController

- (void)dealloc {
    NSLog(@"MKBXBTabBarController销毁");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![[self.navigationController viewControllers] containsObject:self]){
        [[MKBXBCentralManager shared] disconnect];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubPages];
    [self addNotifications];
}

#pragma mark - notes
- (void)gotoScanPage {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
//        @strongify(self);
//        if ([self.delegate respondsToSelector:@selector(mk_bxb_needResetScanDelegate:)]) {
//            [self.delegate mk_bxb_needResetScanDelegate:NO];
//        }
    }];
}

#pragma mark - private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoScanPage)
                                                 name:@"mk_bxb_popToRootViewControllerNotification"
                                               object:nil];
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
