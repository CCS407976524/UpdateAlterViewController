//
//  VersionUpdateTableViewCell.m
//  TCMerchant
//
//  Created by phoniex on 2019/4/29.
//  Copyright © 2019 phoniex. All rights reserved.
//

#import "VersionUpdateTableViewCell.h"
static NSString * updateCell = @"updateCell";
@interface VersionUpdateTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel * reason;

@end

@implementation VersionUpdateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    VersionUpdateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:updateCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle ] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setData:(NSString *)data
{
    self.reason.text = data;
}

@end
