//
//  MKBXBPowerSaveTriggerTimeCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBPowerSaveTriggerTimeCellModel : NSObject

@property (nonatomic, copy)NSString *time;

@end

@protocol MKBXBPowerSaveTriggerTimeCellDelegate <NSObject>

- (void)bxb_powerSaveTriggerTimeChanged:(NSString *)time;

@end

@interface MKBXBPowerSaveTriggerTimeCell : MKBaseCell

@property (nonatomic, strong)MKBXBPowerSaveTriggerTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKBXBPowerSaveTriggerTimeCellDelegate>delegate;

+ (MKBXBPowerSaveTriggerTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
