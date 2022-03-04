//
//  MKBXBAlarmEventCountCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBAlarmEventCountCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *count;

@end

@protocol MKBXBAlarmEventCountCellDelegate <NSObject>

- (void)bxb_alarmEvent_checkButtonPressed:(NSInteger)index;

- (void)bxb_alarmEvent_clearButtonPressed:(NSInteger)index;

- (void)bxb_alarmEvent_exportButtonPressed:(NSInteger)index;

@end

@interface MKBXBAlarmEventCountCell : MKBaseCell

@property (nonatomic, strong)MKBXBAlarmEventCountCellModel *dataModel;

@property (nonatomic, weak)id <MKBXBAlarmEventCountCellDelegate>delegate;

+ (MKBXBAlarmEventCountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
