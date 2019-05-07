//
//  VersionUpdateViewController.m
//  TCMerchant
//
//  Created by phoniex on 2019/4/29.
//  Copyright © 2019 phoniex. All rights reserved.
//

#import "VersionUpdateViewController.h"
#import "VersionUpdateView.h"
@interface VersionUpdateViewController ()
@property (nonatomic ,strong)  VersionUpdateView * topView;
@end

@implementation VersionUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self initSubviews];
}

-(void)initSubviews
{
    typeof(self) __weak weakSelf = self;
    self.topView = [[VersionUpdateView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.topView];
    self.topView.layer.cornerRadius = 4;
    self.topView.layer.masksToBounds = YES;
    self.topView.cancleBlock = ^{
        [weakSelf cancleAction];
    };
    self.topView.confirmBlock = ^{
        [weakSelf confirmAction];
    };
    [self setTopImageView:self.imageName CancleTitleColor:self.cancleColor confirmTitleColor:self.confirmColor];
}

-(void)setTopImageView:(NSString *)imageName CancleTitleColor:(UIColor *)cancleColor confirmTitleColor:(UIColor *)confirmColor
{
    [self.topView setTopImageVImage:imageName];
    [self.topView setCancleBtnTitleColor:cancleColor];
    [self.topView setConfirmBtnTitleColor:confirmColor];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).with.offset(56);
        make.trailing.mas_equalTo(self.view.mas_trailing).with.offset(-56);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IS_VALID_ARRAY(self.dataArray)) {
        [self.topView.dataArray removeAllObjects];
        self.topView.dataArray = self.dataArray;
        [self.topView.updateFunctionTableView reloadData];
    }
}

-(void)cancleAction
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}

-(void)confirmAction
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}
@end
