//
//  MKBXBScanAdvCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBScanAdvCellModel : NSObject

/// 0:Single 1:Double 2:Long 3:Abnormal inactivity
@property (nonatomic, assign)NSInteger alarmMode;

@property (nonatomic, assign)BOOL triggerStatus;

@property (nonatomic, copy)NSString *triggerCount;

@property (nonatomic, copy)NSString *deviceID;

@end

@interface MKBXBScanAdvCell : MKBaseCell

@property (nonatomic, strong)MKBXBScanAdvCellModel *dataModel;

+ (MKBXBScanAdvCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
