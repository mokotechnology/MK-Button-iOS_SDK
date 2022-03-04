//
//  MKBXBScanDeviceInfoCell.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBScanDeviceInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKBXBScanDeviceInfoCellModel
@end

@interface MKBXBScanDeviceInfoCell ()

@property (nonatomic, strong)UIImageView *leftIcon;

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *rangingLabel;

@property (nonatomic, strong)UILabel *rangingValueLabel;

@property (nonatomic, strong)UILabel *accelerationLabel;

@property (nonatomic, strong)UILabel *accelerationValueLabel;

@end

@implementation MKBXBScanDeviceInfoCell

+ (MKBXBScanDeviceInfoCell *)initCellWithTableView:(UITableView *)tableView {
    MKBXBScanDeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBXBScanDeviceInfoCellIdenty"];
    if (!cell) {
        cell = [[MKBXBScanDeviceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBXBScanDeviceInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftIcon];
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.rangingLabel];
        [self.contentView addSubview:self.rangingValueLabel];
        [self.contentView addSubview:self.accelerationLabel];
        [self.contentView addSubview:self.accelerationValueLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.width.mas_equalTo(7.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(7.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIcon.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-10.f);
        make.centerY.mas_equalTo(self.leftIcon.mas_centerY);
        make.height.mas_equalTo(MKFont(15).lineHeight);
    }];
    [self.rangingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.rangingValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(5.f);
        make.right.mas_equalTo(-10.f);
        make.centerY.mas_equalTo(self.rangingLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.accelerationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5.f);
        make.top.mas_equalTo(self.rangingValueLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.accelerationValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(5.f);
        make.right.mas_equalTo(-10.f);
        make.centerY.mas_equalTo(self.accelerationLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKBXBScanDeviceInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKBXBScanDeviceInfoCellModel.class]) {
        return;
    }
    self.rangingValueLabel.text = SafeStr(_dataModel.rangingData);
    self.accelerationValueLabel.text = SafeStr(_dataModel.acceleration);
}

#pragma mark - getter
- (UIImageView *)leftIcon{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] init];
        _leftIcon.image = LOADICON(@"MKBeaconXButton", @"MKBXBScanDeviceInfoCell", @"bxb_littleBluePoint.png");
    }
    return _leftIcon;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _msgLabel;
}

- (UILabel *)rangingLabel {
    if (!_rangingLabel) {
        _rangingLabel = [self createLabel];
        _rangingLabel.text = @"Ranging data";
    }
    return _rangingLabel;
}

- (UILabel *)rangingValueLabel {
    if (!_rangingValueLabel) {
        _rangingValueLabel = [self createLabel];
    }
    return _rangingValueLabel;
}

- (UILabel *)accelerationLabel {
    if (!_accelerationLabel) {
        _accelerationLabel = [self createLabel];
        _accelerationLabel.text = @"Acceleration";
    }
    return _accelerationLabel;
}

- (UILabel *)accelerationValueLabel {
    if (!_accelerationValueLabel) {
        _accelerationValueLabel = [self createLabel];
    }
    return _accelerationValueLabel;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = RGBCOLOR(184, 184, 184);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(12.f);
    return label;
}

@end
