//
//  MKBXBDeviceIDCell.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBDeviceIDCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKTextField.h"
#import "MKCustomUIAdopter.h"

@implementation MKBXBDeviceIDCellModel
@end

@interface MKBXBDeviceIDCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *oxLabel;

@property (nonatomic, strong)MKTextField *textField;

@end

@implementation MKBXBDeviceIDCell

+ (MKBXBDeviceIDCell *)initCellWithTableView:(UITableView *)tableView {
    MKBXBDeviceIDCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBXBDeviceIDCellIdenty"];
    if (!cell) {
        cell = [[MKBXBDeviceIDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBXBDeviceIDCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.oxLabel];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(150.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.oxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oxLabel.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKBXBDeviceIDCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKBXBDeviceIDCellModel.class]) {
        return;
    }
    self.textField.text = SafeStr(_dataModel.deviceID);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.text = @"Device ID";
    }
    return _msgLabel;
}

- (UILabel *)oxLabel {
    if (!_oxLabel) {
        _oxLabel = [[UILabel alloc] init];
        _oxLabel.textColor = DEFAULT_TEXT_COLOR;
        _oxLabel.font = MKFont(15.f);
        _oxLabel.textAlignment = NSTextAlignmentLeft;
        _oxLabel.text = @"0x";
    }
    return _oxLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                          placeHolder:@"1-8 bytes"
                                                             textType:mk_hexCharOnly];
        _textField.maxLength = 16;
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(bxb_deviceIDChanged:)]) {
                [self.delegate bxb_deviceIDChanged:text];
            }
        };
    }
    return _textField;
}

@end
