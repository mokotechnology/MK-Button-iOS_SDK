//
//  MKBXBNotificationTypePickerView.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/21.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBNotificationTypePickerViewModel : NSObject

/// 是否显示顶部按钮和按钮那一行的label
@property (nonatomic, assign)BOOL needButton;

/// 跟button一行的msgLabel显示内容(needButton=YES有效)
@property (nonatomic, copy)NSString *msg;

/// 蓝色按钮标题(可以选择不显示)(needButton=YES有效)
@property (nonatomic, copy)NSString *buttonTitle;

/// pickerView一行的label显示内容
@property (nonatomic, copy)NSString *typeLabelMsg;

@end

@protocol MKBXBNotificationTypePickerViewDelegate <NSObject>

- (void)bxb_notiTypePickerViewTypeChanged:(NSInteger)type;

@optional
- (void)bxb_notiTypePickerViewButtonPressed;

@end

@interface MKBXBNotificationTypePickerView : UIView

@property (nonatomic, weak)id <MKBXBNotificationTypePickerViewDelegate>delegate;

@property (nonatomic, strong)MKBXBNotificationTypePickerViewModel *dataModel;

/// 更新pickerView
/// @param notiType 参见下面
/*
0:Silent
1:LED
2:Vibration
3:Buzzer
4:LED+Vibration
5:LED+Buzzer
*/
- (void)updateNotificationType:(NSInteger)notiType;

@end

NS_ASSUME_NONNULL_END
