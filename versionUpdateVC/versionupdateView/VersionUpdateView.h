//
//  VersionUpdateView.h
//  TCMerchant
//
//  Created by phoniex on 2019/4/29.
//  Copyright © 2019 phoniex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^cancleBtnActionBlock)(void);

typedef void(^confirmBtnActionBlock)(void);
@interface VersionUpdateView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,copy) cancleBtnActionBlock  cancleBlock;

@property (nonatomic ,copy) confirmBtnActionBlock  confirmBlock;

@property (nonatomic ,strong) UITableView * updateFunctionTableView;

@property (nonatomic ,strong) NSMutableArray * dataArray;

/**版本更新顶部的图片*/
-(void)setTopImageVImage:(NSString *)imageName;
/**版本更新取消按钮字体色*/
-(void)setCancleBtnTitleColor:(UIColor *)color;
/**版本更新确认按钮字体色*/
-(void)setConfirmBtnTitleColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
