//
//  MKBXBTxPowerCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBTxPowerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

/*
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:+3dBm
 8:+4dBm
 */
@property (nonatomic, assign)NSInteger txPower;

@end

@protocol MKBXBTxPowerCellDelegate <NSObject>

/// txPower改变回调
/// @param index index
/// @param txPower 参见
/*
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:+3dBm
 8:+4dBm
 */
- (void)bxb_txPowerChanged:(NSInteger)index txPower:(NSInteger)txPower;

@end

@interface MKBXBTxPowerCell : MKBaseCell

@property (nonatomic, strong)MKBXBTxPowerCellModel *dataModel;

@property (nonatomic, weak)id <MKBXBTxPowerCellDelegate>delegate;

+ (MKBXBTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
