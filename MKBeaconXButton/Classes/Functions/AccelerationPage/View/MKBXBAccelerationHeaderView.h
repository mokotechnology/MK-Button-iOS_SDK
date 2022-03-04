//
//  MKBXBAccelerationHeaderView.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2021/3/3.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKBXBAccelerationHeaderViewDelegate <NSObject>

- (void)bxb_updateThreeAxisNotifyStatus:(BOOL)notify;

@end

@interface MKBXBAccelerationHeaderView : UIView

@property (nonatomic, weak)id <MKBXBAccelerationHeaderViewDelegate>delegate;

- (void)updateDataWithXData:(NSString *)xData yData:(NSString *)yData zData:(NSString *)zData;

@end

NS_ASSUME_NONNULL_END
