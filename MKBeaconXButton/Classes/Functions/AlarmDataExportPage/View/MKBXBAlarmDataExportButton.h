//
//  MKBXBAlarmDataExportButton.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/3/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBAlarmDataExportButtonModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIImage *icon;

@end

@interface MKBXBAlarmDataExportButton : UIControl

@property (nonatomic, strong)MKBXBAlarmDataExportButtonModel *dataModel;

@end

NS_ASSUME_NONNULL_END
