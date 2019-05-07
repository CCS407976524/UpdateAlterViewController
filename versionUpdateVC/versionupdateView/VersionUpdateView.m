//
//  VersionUpdateView.m
//  TCMerchant
//
//  Created by phoniex on 2019/4/29.
//  Copyright © 2019 phoniex. All rights reserved.
//

#import "VersionUpdateView.h"
#import "VersionUpdateTableViewCell.h"
static NSInteger cellHeight = 50;
static NSString * versionUpdateCellID = @"versionUpdateCellID";
@interface VersionUpdateView ()
@property (nonatomic ,strong) UILabel * topTips;//顶部提示语

@property (nonatomic ,strong) UILabel * version;//版本号

@property (nonatomic ,strong) UIImageView * topImageV;

@property (nonatomic ,strong) UIButton * cancleBtn;

@property (nonatomic ,strong) UIButton * confirmBtn;

@property (nonatomic ,strong) UIView * lineView;

@property (nonatomic ,strong) UIView * separateLineView;
@end
@implementation VersionUpdateView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(void)initSubviews
{
    self.topImageV = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.topImageV];
    
    self.topTips = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.topImageV addSubview:self.topTips];
    self.topTips.font = [UIFont boldSystemFontOfSize:16];
    self.topTips.textColor = UIColorFromRGB(0xfcfcfc);
    self.topTips.text = @"发现新版本";
    self.topTips.textAlignment = NSTextAlignmentLeft;
    
    self.version = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.topImageV addSubview:self.version];
    self.version.font = [UIFont systemFontOfSize:12];
    self.version.textColor = UIColorFromRGB(0xfcfcfc);
    self.version.textAlignment = NSTextAlignmentLeft;
    self.version.text = [NSString stringWithFormat:@"V%@",[self getNativeVersion]];
    
    self.updateFunctionTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.updateFunctionTableView];
    self.updateFunctionTableView.delegate = self;
    self.updateFunctionTableView.dataSource = self;
    
    self.cancleBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self addSubview:self.cancleBtn];
    [self.cancleBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn.backgroundColor = [UIColor whiteColor];
    [self.cancleBtn setTitle:@"稍后再说" forState:UIControlStateNormal];
    self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.confirmBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self addSubview:self.confirmBtn];
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn.backgroundColor = [UIColor whiteColor];
    [self.confirmBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor = UIColorFromRGB(0xd7d7d7);
    
    self.separateLineView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.separateLineView];
    self.separateLineView.backgroundColor = UIColorFromRGB(0xd7d7d7);
    
    self.updateFunctionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
    }];
    
    [self.topTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(47);
        make.leading.mas_equalTo(self.mas_leading).with.offset(16);
        make.height.mas_equalTo(@20);
    }];
    
    [self.version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topTips.mas_bottom).with.offset(12);
        make.leading.mas_equalTo(self.topTips.mas_leading);
    }];
    
    [self.updateFunctionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.topImageV.mas_bottom);
        if (IS_VALID_ARRAY(self.dataArray)) {
            if (self.dataArray.count <= 4) {
                make.height.mas_equalTo(@(self.dataArray.count * cellHeight));
            }else{
                make.height.mas_equalTo(@(4 * cellHeight));
            }
        }
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.updateFunctionTableView.mas_bottom);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(@1);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading);
        make.trailing.mas_equalTo(self.separateLineView.mas_leading);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.height.mas_equalTo(@44);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.separateLineView.mas_trailing);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.height.mas_equalTo(@44);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VersionUpdateTableViewCell * cell = [VersionUpdateTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:self.dataArray[indexPath.row]];
    return cell;
}

-(void)setTopImageVImage:(NSString *)imageName
{
    [self.topImageV setImage:[UIImage imageNamed:imageName]];
}

-(void)setCancleBtnTitleColor:(UIColor *)color
{
    [self.cancleBtn setTitleColor:color forState:UIControlStateNormal];
}

-(void)setConfirmBtnTitleColor:(UIColor *)color
{
    [self.confirmBtn setTitleColor:color forState:UIControlStateNormal];
}

-(void)cancelAction
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

-(NSString *)getNativeVersion
{
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * nativeVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return nativeVersion;
}
@end
