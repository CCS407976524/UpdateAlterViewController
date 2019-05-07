//
//  VersionUpdateTableViewCell.h
//  TCMerchant
//
//  Created by phoniex on 2019/4/29.
//  Copyright © 2019 phoniex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionUpdateTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setData:(NSString *)data;
@end

NS_ASSUME_NONNULL_END
