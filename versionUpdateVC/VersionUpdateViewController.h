//
//  VersionUpdateViewController.h
//  TCMerchant
//
//  Created by phoniex on 2019/4/29.
//  Copyright © 2019 phoniex. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^cancleActionBlock)(void);

typedef void(^confirmActionBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface VersionUpdateViewController : BaseViewController
@property (nonatomic ,copy) cancleActionBlock  cancleBlock;

@property (nonatomic ,copy) confirmActionBlock  confirmBlock;

@property (nonatomic ,strong) NSString * imageName;

@property (nonatomic ,strong) UIColor * cancleColor;

@property (nonatomic ,strong) UIColor * confirmColor;

@property (nonatomic ,strong) NSMutableArray * dataArray;

@end

NS_ASSUME_NONNULL_END
