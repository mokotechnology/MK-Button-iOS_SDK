//
//  MKButtonMsgCell.m
//  Pods
//
//  Created by aa on 2022/11/30.
//

#import "MKButtonMsgCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

static CGFloat const offset_X = 15.f;
static CGFloat const selectButtonWidth = 130.f;
static CGFloat const selectButtonHeight = 30.f;

@implementation MKButtonMsgCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.buttonEnable = YES;
    }
    return self;
}

- (CGFloat)cellHeightWithContentWidth:(CGFloat)width {
    UIFont *msgFont = (self.msgFont ? self.msgFont : MKFont(15.f));
    CGFloat msgWith = width - 3 * offset_X - selectButtonWidth;
    CGSize msgSize = [NSString sizeWithText:self.msg
                                    andFont:msgFont
                                 andMaxSize:CGSizeMake(msgWith, MAXFLOAT)];
    if (!ValidStr(self.noteMsg)) {
        //没有底部note内容
        return MAX(msgSize.height + 2 * offset_X, 50.f);
    }
    //存在底部的note
    UIFont *noteFont = (self.noteMsgFont ? self.noteMsgFont : MKFont(12.f));
    CGSize noteSize = [NSString sizeWithText:self.noteMsg
                                     andFont:noteFont
                                  andMaxSize:CGSizeMake(width - 2 * offset_X, MAXFLOAT)];
    return MAX(msgSize.height + 2 * offset_X, 50.f) + noteSize.height + 10.f;
}

@end

@interface MKButtonMsgCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *selectedButton;

@property (nonatomic, strong)UILabel *noteLabel;

@end

@implementation MKButtonMsgCell

+ (MKButtonMsgCell *)initCellWithTableView:(UITableView *)tableView {
    MKButtonMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKButtonMsgCellIdenty"];
    if (!cell) {
        cell = [[MKButtonMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKButtonMsgCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.selectedButton];
        [self.contentView addSubview:self.noteLabel];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    BOOL hasNote = ValidStr(self.noteLabel.text);
    CGSize msgSize = [self msgSize];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(offset_X);
        make.width.mas_equalTo(msgSize.width);
        if (hasNote) {
            //底部有note标签内容
            make.top.mas_equalTo(offset_X);
        }else {
            //底部没有note标签,则上下居中
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }
        
        make.height.mas_equalTo(msgSize.height);
    }];
    
    [self.selectedButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-offset_X);
        make.width.mas_equalTo(selectButtonWidth);
        make.centerY.mas_equalTo(self.msgLabel.mas_centerY);
        make.height.mas_equalTo(selectButtonHeight);
    }];
    CGSize noteSize = [self noteSize];
    [self.noteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(offset_X);
        make.right.mas_equalTo(-offset_X);
        make.bottom.mas_equalTo(-offset_X);
        make.height.mas_equalTo(noteSize.height);
    }];
}

#pragma mark - event method
- (void)selectedButtonPressed {
    if ([self.delegate respondsToSelector:@selector(mk_buttonMsgCellButtonPressed:)]) {
        [self.delegate mk_buttonMsgCellButtonPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKButtonMsgCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKButtonMsgCellModel.class]) {
        return;
    }
    self.contentView.backgroundColor = (_dataModel.contentColor ? _dataModel.contentColor : COLOR_WHITE_MACROS);
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.msgLabel.font = (_dataModel.msgFont ? _dataModel.msgFont : MKFont(15.f));
    self.msgLabel.textColor = (_dataModel.msgColor ? _dataModel.msgColor : DEFAULT_TEXT_COLOR);
    self.selectedButton.enabled = _dataModel.buttonEnable;
    [self.selectedButton setTitle:SafeStr(_dataModel.buttonTitle) forState:UIControlStateNormal];
    if (_dataModel.buttonLabelFont) {
        [self.selectedButton.titleLabel setFont:_dataModel.buttonLabelFont];
    }else {
        [self.selectedButton.titleLabel setFont:MKFont(15.f)];
    }
    if (_dataModel.buttonBackColor) {
        [self.selectedButton setBackgroundColor:_dataModel.buttonBackColor];
    }else {
        [self.selectedButton setBackgroundColor:NAVBAR_COLOR_MACROS];
    }
    if (_dataModel.buttonTitleColor) {
        [self.selectedButton setTitleColor:_dataModel.buttonTitleColor forState:UIControlStateNormal];
    }else {
        [self.selectedButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
    }
    self.noteLabel.text = SafeStr(_dataModel.noteMsg);
    self.noteLabel.font = (_dataModel.noteMsgFont ? _dataModel.noteMsgFont : MKFont(12.f));
    self.noteLabel.textColor = (_dataModel.noteMsgColor ? _dataModel.noteMsgColor : DEFAULT_TEXT_COLOR);
    [self setNeedsLayout];
}

- (CGSize)msgSize {
    if (!ValidStr(self.msgLabel.text)) {
        return CGSizeMake(0, 0);
    }
    CGFloat maxMsgWidth = self.contentView.frame.size.width - 3 * offset_X - selectButtonWidth;
    CGSize msgSize = [NSString sizeWithText:self.msgLabel.text
                                    andFont:self.msgLabel.font
                                 andMaxSize:CGSizeMake(maxMsgWidth, MAXFLOAT)];
    return CGSizeMake(maxMsgWidth, msgSize.height);
}

- (CGSize)noteSize {
    if (!ValidStr(self.noteLabel.text)) {
        return CGSizeMake(0, 0);
    }
    CGFloat width = self.contentView.frame.size.width - 2 * offset_X;
    CGSize noteSize = [NSString sizeWithText:self.noteLabel.text
                                     andFont:self.noteLabel.font
                                  andMaxSize:CGSizeMake(width, MAXFLOAT)];
    return CGSizeMake(width, noteSize.height);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.numberOfLines = 0;
    }
    return _msgLabel;
}

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textColor = DEFAULT_TEXT_COLOR;
        _noteLabel.font = MKFont(12.f);
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_selectedButton setBackgroundColor:NAVBAR_COLOR_MACROS];
        [_selectedButton.layer setMasksToBounds:YES];
        [_selectedButton.layer setCornerRadius:6.f];
        [_selectedButton addTarget:self
                            action:@selector(selectedButtonPressed)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

@end
