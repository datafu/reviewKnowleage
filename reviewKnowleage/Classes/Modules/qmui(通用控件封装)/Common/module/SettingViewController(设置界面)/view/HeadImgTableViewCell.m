//
//  HeadImgTableViewCell.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/20.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "HeadImgTableViewCell.h"

@interface HeadImgTableViewCell()
@end


@implementation HeadImgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headimgBtn];
    }
    return self;
}

- (instancetype)initForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   return  [super initForTableView:tableView withStyle:style reuseIdentifier:reuseIdentifier];
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
////        self.parentTableView = tableView;
//
//    }
//
//    return self;
}


- (QMUIButton*)headimgBtn {
    if (!_headimgBtn) {
        _headimgBtn = [[QMUIButton alloc] qmui_initWithSize:CGSizeMake(35, 35)];
        [_headimgBtn setImage:[UIImage imageNamed:@"setting_head_currency_ico"] forState:0];
        [self addSubview:_headimgBtn];
    }
    return _headimgBtn;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _headimgBtn.frame = CGRectSetY(_headimgBtn.frame,CGFloatGetCenter(CGRectGetHeight(self.frame),35));
    _headimgBtn.frame = CGRectSetX(_headimgBtn.frame, CGRectGetMaxX(self.detailTextLabel.frame)- 35);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
