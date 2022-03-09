//
//  MKBXBScanDeviceDataCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@class MKBXBScanDataModel;
@protocol MKBXBScanDeviceDataCellDelegate <NSObject>

- (void)mk_bxb_connectPeripheral:(CBPeripheral *)peripheral;

@end
@interface MKBXBScanDeviceDataCell : MKBaseCell

@property (nonatomic, strong)MKBXBScanDataModel *dataModel;

@property (nonatomic, weak)id <MKBXBScanDeviceDataCellDelegate>delegate;

+ (MKBXBScanDeviceDataCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
