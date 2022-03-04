//
//  MKBXBScanController.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBScanController.h"

#import <objc/runtime.h>

#import <CoreBluetooth/CoreBluetooth.h>

#import "Masonry.h"

#import "UIViewController+HHTransition.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSObject+MKModel.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"
#import "MKProgressView.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertController.h"

#import "MKBXScanFilterView.h"
#import "MKBXScanSearchButton.h"

#import "MKBXBSDK.h"

#import "MKBXBConnectManager.h"

#import "MKBXBScanPageAdopter.h"

#import "MKBXBScanDataModel.h"

#import "MKBXBScanDeviceDataCell.h"
#import "MKBXBScanAdvCell.h"
#import "MKBXBScanDeviceInfoCell.h"

#import "MKBXBTabBarController.h"
#import "MKBXBAboutController.h"

static CGFloat const offset_X = 15.f;
static CGFloat const searchButtonHeight = 40.f;
static CGFloat const headerViewHeight = 90.f;

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKBXBScanController ()<UITableViewDelegate,
UITableViewDataSource,
MKBXScanSearchButtonDelegate,
mk_bxb_centralManagerScanDelegate,
MKBXBScanDeviceDataCellDelegate,
MKBXBTabBarControllerDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKBXScanSearchButtonModel *buttonModel;

@property (nonatomic, strong)MKBXScanSearchButton *searchButton;

@property (nonatomic, strong)UIImageView *refreshIcon;

@property (nonatomic, strong)UIButton *refreshButton;

@property (nonatomic, strong)dispatch_source_t scanTimer;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//扫描到新的设备不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@property (nonatomic, strong)UITextField *passwordField;

@end

@implementation MKBXBScanController

- (void)dealloc {
    NSLog(@"MKBXBScanController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
    [[MKBXBCentralManager shared] stopScan];
    [MKBXBCentralManager removeFromCentralList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self startRefresh];
}

#pragma mark - super method
- (void)rightButtonMethod {
    MKBXBAboutController *vc = [[MKBXBAboutController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MKBXBScanDataModel *model = self.dataList[section];
    return (model.advertiseList.count + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //第一个row固定为设备信息帧
        MKBXBScanDeviceDataCell *cell = [MKBXBScanDeviceDataCell initCellWithTableView:tableView];
        cell.dataModel = self.dataList[indexPath.section];
        cell.delegate = self;
        return cell;
    }
    MKBXBScanDataModel *model = self.dataList[indexPath.section];
    
    NSObject *obj = model.advertiseList[indexPath.row - 1];
    if ([obj isKindOfClass:MKBXBScanDeviceInfoCellModel.class]) {
        MKBXBScanDeviceInfoCell *cell = [MKBXBScanDeviceInfoCell initCellWithTableView:tableView];
        cell.dataModel = obj;
        return cell;
    }
    
    MKBXBScanAdvCell *cell = [MKBXBScanAdvCell initCellWithTableView:tableView];
    cell.dataModel = obj;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return headerViewHeight;
    }
    MKBXBScanDataModel *model = self.dataList[indexPath.section];
    NSObject *obj = model.advertiseList[indexPath.row - 1];
    if ([obj isKindOfClass:MKBXBScanDeviceInfoCellModel.class]) {
        return 80.f;
    }
    if ([obj isKindOfClass:MKBXBScanAdvCellModel.class]) {
        return 90.f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.f;
    }
    return 5.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    MKTableSectionLineHeaderModel *sectionData = [[MKTableSectionLineHeaderModel alloc] init];
    sectionData.contentColor = RGBCOLOR(237, 243, 250);
    headerView.headerModel = sectionData;
    return headerView;
}

#pragma mark - MKBXScanSearchButtonDelegate
- (void)mk_bx_scanSearchButtonMethod {
    [MKBXScanFilterView showSearchName:self.buttonModel.searchName
                            macAddress:self.buttonModel.searchMac
                                  rssi:self.buttonModel.searchRssi
                           searchBlock:^(NSString * _Nonnull searchName, NSString * _Nonnull searchMacAddress, NSInteger searchRssi) {
        self.buttonModel.searchRssi = searchRssi;
        self.buttonModel.searchName = searchName;
        self.buttonModel.searchMac = searchMacAddress;
        self.searchButton.dataModel = self.buttonModel;
        
        self.refreshButton.selected = NO;
        [self refreshButtonPressed];
    }];
}

- (void)mk_bx_scanSearchButtonClearMethod {
    self.buttonModel.searchRssi = -100;
    self.buttonModel.searchMac = @"";
    self.buttonModel.searchName = @"";
    self.refreshButton.selected = NO;
    [self refreshButtonPressed];
}

#pragma mark - mk_bxb_centralManagerScanDelegate
- (void)mk_bxb_receiveAdvData:(MKBXBBaseAdvModel *)advModel {
    [self updateDataWithAdvModel:advModel];
}

- (void)mk_bxb_stopScan {
    //如果是左上角在动画，则停止动画
    if (self.refreshButton.isSelected) {
        [self.refreshIcon.layer removeAnimationForKey:@"mk_refreshAnimationKey"];
        [self.refreshButton setSelected:NO];
    }
}

#pragma mark - MKBXBScanDeviceDataCellDelegate
- (void)mk_bxb_connectPeripheral:(CBPeripheral *)peripheral {
    [self connectPeripheral:peripheral];
}

#pragma mark - MKBXBTabBarControllerDelegate
- (void)mk_bxb_needResetScanDelegate:(BOOL)need {
    if (need) {
        [MKBXBCentralManager shared].delegate = self;
    }
    [self performSelector:@selector(startScanDevice) withObject:nil afterDelay:(need ? 1.f : 0.1f)];
}

#pragma mark - event method
- (void)refreshButtonPressed {
    if ([MKBXBCentralManager shared].centralStatus != mk_bxb_centralManagerStatusEnable) {
        [self.view showCentralToast:@"The current system of bluetooth is not available!"];
        return;
    }
    self.refreshButton.selected = !self.refreshButton.selected;
    [self.refreshIcon.layer removeAnimationForKey:@"mk_refreshAnimationKey"];
    if (!self.refreshButton.isSelected) {
        //停止扫描
        [[MKBXBCentralManager shared] stopScan];
        return;
    }
    [self.dataList removeAllObjects];
    [self.tableView reloadData];
    //刷新顶部设备数量
    [self.titleLabel setText:[NSString stringWithFormat:@"DEVICE(%@)",[NSString stringWithFormat:@"%ld",(long)self.dataList.count]]];
    [self.refreshIcon.layer addAnimation:[MKCustomUIAdopter refreshAnimation:2.f] forKey:@"mk_refreshAnimationKey"];
    [[MKBXBCentralManager shared] startScan];
}

#pragma mark - notice method
- (void)showCentralStatus{
    if ([MKBXBCentralManager shared].centralStatus != mk_bxb_centralManagerStatusEnable) {
        NSString *msg = @"The current system of bluetooth is not available!";
        MKAlertController *alertController = [MKAlertController alertControllerWithTitle:@"Dismiss"
                                                                                 message:msg
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:moreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    [self refreshButtonPressed];
}

#pragma mark - 刷新
- (void)startScanDevice {
    self.refreshButton.selected = NO;
    [self refreshButtonPressed];
}

- (void)needRefreshList {
    //标记需要刷新
    self.isNeedRefresh = YES;
    //唤醒runloop
    CFRunLoopWakeUp(CFRunLoopGetMain());
}

- (void)runloopObserver {
    @weakify(self);
    __block NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    self.observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        @strongify(self);
        if (activity == kCFRunLoopBeforeWaiting) {
            //runloop空闲的时候刷新需要处理的列表,但是需要控制刷新频率
            NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
            if (currentInterval - timeInterval < kRefreshInterval) {
                return;
            }
            timeInterval = currentInterval;
            if (self.isNeedRefresh) {
                [self.tableView reloadData];
                [self.titleLabel setText:[NSString stringWithFormat:@"DEVICE(%@)",[NSString stringWithFormat:@"%ld",(long)self.dataList.count]]];
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)updateDataWithAdvModel:(MKBXBBaseAdvModel *)advData{
    if (!advData || advData.frameType == MKBXBUnknownFrameType) {
        return;
    }
    if (ValidStr(self.buttonModel.searchMac) || ValidStr(self.buttonModel.searchName)) {
        //如果打开了过滤，先看是否需要过滤设备名字和mac地址
        //如果是设备信息帧,判断mac和名字是否符合要求
        if ([advData.rssi integerValue] >= self.buttonModel.searchRssi && [self filterAdvDataWithSearchName:advData]) {
            [self processAdvData:advData];
        }
        return;
    }
    if (self.buttonModel.searchRssi > self.buttonModel.minSearchRssi) {
        //开启rssi过滤
        if ([advData.rssi integerValue] >= self.buttonModel.searchRssi) {
            [self processAdvData:advData];
        }
        return;
    }
    [self processAdvData:advData];
}

/**
 通过设备名称和mac地址过滤设备，这个时候肯定开启了rssi
 
 @param advData 设备
 */
- (BOOL)filterAdvDataWithSearchName:(MKBXBBaseAdvModel *)advData {
    if ([advData isKindOfClass:MKBXBAdvDataModel.class]) {
        //广播包才有设备名称
        if ([[advData.deviceName uppercaseString] containsString:[self.buttonModel.searchName uppercaseString]]) {
            return YES;
        }
    }
    if ([advData isKindOfClass:MKBXBAdvRespondDataModel.class]) {
        //回应包才有mac地址
        MKBXBAdvRespondDataModel *tempModel = (MKBXBAdvRespondDataModel *)advData;
        if ([[[tempModel.macAddress stringByReplacingOccurrencesOfString:@":" withString:@""] uppercaseString] containsString:[self.buttonModel.searchMac uppercaseString]]) {
            return YES;
        }
    }
    return NO;
}

- (void)processAdvData:(MKBXBBaseAdvModel *)advData {
    //查看数据源中是否已经存在相关设备
    NSString *identy = advData.peripheral.identifier.UUIDString;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identy];
    NSArray *array = [self.dataList filteredArrayUsingPredicate:predicate];
    BOOL contain = ValidArray(array);
    if (contain) {
        //如果是当前设备信息帧已经存在了，则判断是不是设备信息帧数组已经包含该项数据，包含则替换，不包含则添加
        [MKBXBScanPageAdopter updateInfoCellModel:array[0] advData:advData];
        [self needRefreshList];
        return;
    }
    //不存在，则加入到dataList里面去
    MKBXBScanDataModel *deviceModel = [MKBXBScanPageAdopter parseBaseAdvDataToInfoModel:advData];
    [self.dataList addObject:deviceModel];
    [self needRefreshList];
}

#pragma mark - 连接设备

- (void)connectPeripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [self.refreshIcon.layer removeAnimationForKey:@"mk_refreshAnimationKey"];
    [[MKBXBCentralManager shared] stopScan];
    NSString *alertTitle = @"Please enter password.";
    MKAlertController *alertController = [MKAlertController alertControllerWithTitle:alertTitle
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        @strongify(self);
        self.passwordField = nil;
        self.passwordField = textField;
        if (ValidStr([[NSUserDefaults standardUserDefaults] objectForKey:@"mk_bxb_localPasswordKey"])) {
            textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"mk_bxb_localPasswordKey"];
        }
        self.passwordField.placeholder = @"No more than 16 characters.";
        [textField addTarget:self action:@selector(passwordInput) forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self connectFailed];
    }];
    [alertController addAction:cancelAction];
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self connectDeviceWithPassword:peripheral];
    }];
    [alertController addAction:moreAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 监听输入的密码
 */
- (void)passwordInput{
    NSString *tempInputString = self.passwordField.text;
    if (!ValidStr(tempInputString)) {
        self.passwordField.text = @"";
        return;
    }
    self.passwordField.text = (tempInputString.length > 16 ? [tempInputString substringToIndex:16] : tempInputString);
}

- (void)connectDeviceWithPassword:(CBPeripheral *)peripheral{
    NSString *password = self.passwordField.text;
    if (!ValidStr(password) || password.length > 16) {
        [self.view showCentralToast:@"Password incorrect!"];
        [self connectFailed];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [[MKBXBCentralManager shared] connectPeripheral:peripheral password:password sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        [[MKHudManager share] hide];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"mk_bxb_localPasswordKey"];
        [MKBXBConnectManager shared].needPassword = YES;
        [MKBXBConnectManager shared].password = password;
        [self performSelector:@selector(pushTabBarPage) withObject:nil afterDelay:0.6f];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self connectFailed];
    }];
}

- (void)pushTabBarPage {
    MKBXBTabBarController *vc = [[MKBXBTabBarController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    @weakify(self);
    [self hh_presentViewController:vc presentStyle:HHPresentStyleErected completion:^{
        @strongify(self);
        vc.delegate = self;
    }];
}

- (void)connectFailed {
    self.refreshButton.selected = NO;
    [self refreshButtonPressed];
}

#pragma mark -
- (void)startRefresh {
    self.searchButton.dataModel = self.buttonModel;
    [self runloopObserver];
    [MKBXBCentralManager shared].delegate = self;
    [self performSelector:@selector(showCentralStatus) withObject:nil afterDelay:.5f];
}

#pragma mark - UI
- (void)loadSubViews {
    [self.view setBackgroundColor:RGBCOLOR(237, 243, 250)];
    [self.rightButton setImage:LOADICON(@"MKBeaconXButton", @"MKBXBScanController", @"bxb_scanRightAboutIcon.png") forState:UIControlStateNormal];
    self.titleLabel.text = @"DEVICE(0)";
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = RGBCOLOR(237, 243, 250);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.height.mas_equalTo(searchButtonHeight + 2 * 15.f);
    }];
    [self.refreshButton addSubview:self.refreshIcon];
    [topView addSubview:self.refreshButton];
    [self.refreshIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.refreshButton.mas_centerX);
        make.centerY.mas_equalTo(self.refreshButton.mas_centerY);
        make.width.mas_equalTo(22.f);
        make.height.mas_equalTo(22.f);
    }];
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(40.f);
    }];
    [topView addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.refreshButton.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(searchButtonHeight);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(-VirtualHomeHeight - 5.f);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_WHITE_MACROS;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)refreshIcon {
    if (!_refreshIcon) {
        _refreshIcon = [[UIImageView alloc] init];
        _refreshIcon.image = LOADICON(@"MKBeaconXButton", @"MKBXBScanController", @"bxb_scan_refreshIcon.png");
    }
    return _refreshIcon;
}

- (MKBXScanSearchButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[MKBXScanSearchButton alloc] init];
        _searchButton.delegate = self;
    }
    return _searchButton;
}

- (MKBXScanSearchButtonModel *)buttonModel {
    if (!_buttonModel) {
        _buttonModel = [[MKBXScanSearchButtonModel alloc] init];
        _buttonModel.placeholder = @"Edit Filter";
        _buttonModel.minSearchRssi = -100;
        _buttonModel.searchRssi = -100;
    }
    return _buttonModel;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UIButton *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshButton addTarget:self
                           action:@selector(refreshButtonPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshButton;
}

@end
