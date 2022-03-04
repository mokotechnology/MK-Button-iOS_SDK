//
//  MKBXBRemoteReminderCell.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/3/3.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBRemoteReminderCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKBXBRemoteReminderCellDelegate <NSObject>

- (void)bxb_remindButtonPressed:(NSInteger)index;

@end

@interface MKBXBRemoteReminderCell : MKBaseCell

@property (nonatomic, strong)MKBXBRemoteReminderCellModel *dataModel;

@property (nonatomic, weak)id <MKBXBRemoteReminderCellDelegate>delegate;

+ (MKBXBRemoteReminderCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
