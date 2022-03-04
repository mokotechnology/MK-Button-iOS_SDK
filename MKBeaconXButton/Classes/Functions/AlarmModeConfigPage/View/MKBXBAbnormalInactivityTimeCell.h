//
//  MKBXBAbnormalInactivityTimeCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/21.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBAbnormalInactivityTimeCellModel : NSObject

@property (nonatomic, copy)NSString *time;

@end

@protocol MKBXBAbnormalInactivityTimeCellDelegate <NSObject>

- (void)bxb_abnormalInactivityTimeChanged:(NSString *)time;

@end

@interface MKBXBAbnormalInactivityTimeCell : MKBaseCell

@property (nonatomic, strong)MKBXBAbnormalInactivityTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKBXBAbnormalInactivityTimeCellDelegate>delegate;

+ (MKBXBAbnormalInactivityTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
