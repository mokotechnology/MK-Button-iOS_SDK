//
//  MKBXBDeviceIDCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBDeviceIDCellModel : NSObject

@property (nonatomic, copy)NSString *deviceID;

@end

@protocol MKBXBDeviceIDCellDelegate <NSObject>

- (void)bxb_deviceIDChanged:(NSString *)text;

@end

@interface MKBXBDeviceIDCell : MKBaseCell

@property (nonatomic, weak)id <MKBXBDeviceIDCellDelegate>delegate;

@property (nonatomic, strong)MKBXBDeviceIDCellModel *dataModel;

+ (MKBXBDeviceIDCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
