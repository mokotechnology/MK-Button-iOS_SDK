//
//  MKBXBScanDeviceInfoCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBScanDeviceInfoCellModel : NSObject

@property (nonatomic, copy)NSString *rangingData;

@property (nonatomic, copy)NSString *acceleration;

@end

@interface MKBXBScanDeviceInfoCell : MKBaseCell

@property (nonatomic, strong)MKBXBScanDeviceInfoCellModel *dataModel;

+ (MKBXBScanDeviceInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
