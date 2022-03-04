//
//  MKBXBPowerSaveTriggerTimeCell.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBPowerSaveTriggerTimeCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKTextField.h"
#import "MKCustomUIAdopter.h"

@implementation MKBXBPowerSaveTriggerTimeCellModel
@end

@interface MKBXBPowerSaveTriggerTimeCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)UILabel *noteMsgLabel;

@end

@implementation MKBXBPowerSaveTriggerTimeCell

+ (MKBXBPowerSaveTriggerTimeCell *)initCellWithTableView:(UITableView *)tableView {
    MKBXBPowerSaveTriggerTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBXBPowerSaveTriggerTimeCellIdenty"];
    if (!cell) {
        cell = [[MKBXBPowerSaveTriggerTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBXBPowerSaveTriggerTimeCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.noteMsgLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.textField.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.textField.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.textField.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    CGSize noteSize = [NSString sizeWithText:self.noteMsgLabel.text
                                     andFont:self.noteMsgLabel.font
                                  andMaxSize:CGSizeMake(kViewWidth - 2 * 15.f, MAXFLOAT)];
    [self.noteMsgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.textField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(noteSize.height);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKBXBPowerSaveTriggerTimeCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKBXBPowerSaveTriggerTimeCellModel.class]) {
        return;
    }
    self.textField.text = SafeStr(_dataModel.time);
    self.noteMsgLabel.text = [NSString stringWithFormat:@"*After device keep static for %@s, it will stop advertising and disable alarm mode to enter into power saving mode until device moves. ",SafeStr(_dataModel.time)];
    [self setNeedsLayout];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Static trigger time";
    }
    return _msgLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                          placeHolder:@"1~65535"
                                                             textType:mk_realNumberOnly];
        _textField.maxLength = 5;
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            self.noteMsgLabel.text = [NSString stringWithFormat:@"*After device keep static for %@s, it will stop advertising and disable alarm mode to enter into power saving mode until device moves. ",text];
            [self setNeedsLayout];
            if ([self.delegate respondsToSelector:@selector(bxb_powerSaveTriggerTimeChanged:)]) {
                [self.delegate bxb_powerSaveTriggerTimeChanged:text];
            }
        };
    }
    return _textField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.font = MKFont(11.f);
        _unitLabel.text = @"s";
    }
    return _unitLabel;
}

- (UILabel *)noteMsgLabel {
    if (!_noteMsgLabel) {
        _noteMsgLabel = [[UILabel alloc] init];
        _noteMsgLabel.textColor = [UIColor redColor];
        _noteMsgLabel.textAlignment = NSTextAlignmentLeft;
        _noteMsgLabel.font = MKFont(11.f);
        _noteMsgLabel.numberOfLines = 0;
    }
    return _noteMsgLabel;
}

@end
