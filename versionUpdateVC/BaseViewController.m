//
//  BaseViewController.m
//  findcar
//
//  Created by hongjunjia on 15/9/5.
//  Copyright (c) 2015年 hongjunjia. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+wqBack.h"
#import "BaseEmptyView.h"
#import <Masonry/Masonry.h>
#import "TYTools.h"
#import "TYMacro_common.h"
#import <MJRefresh/MJRefresh.h>
#import "TYUtility.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wq_setUpCustomBack:@"nav_btn_back_white"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isVisible {
    return (self.isViewLoaded && self.view.window);
}

#pragma 键盘时间监听
- (void)keyboardWillShow:(NSNotification*)notif {
}

- (void)keyboardWillHide:(NSNotification*)notif {
    // sub-class implement
}

- (void)registerKeyboardEvent {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unregisterKeyboardEvent {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
}


#pragma mark -- 提示页面显示和隐藏
- (void)disPlayEmptyview:(UIView *)superView
               imageName:(NSString *)name
                    tips:(NSString *)tips
                ishidden:(BOOL)ishidden
                   color:(UIColor *)color
{
    if (superView == nil) {
        superView = self.view;
    }
    [self removeEmptyView:superView];
    BaseEmptyView *emptyView = [[BaseEmptyView alloc] init];
    emptyView.tag = emptyViewTag;
    [superView addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
        if ([superView isKindOfClass:[UIScrollView class]]) {
            make.height.equalTo(superView.mas_height);
            make.width.equalTo(superView.mas_width);
        }
    }];
    if (IS_VALID_STRING(name)) {
        [emptyView setIamgeName:name];
    }
    if (IS_VALID_STRING(tips)) {
        [emptyView setTips:tips];
    }
    [emptyView setIshidden:ishidden];
    if (![TYUtility isEmptyObj:color] ) {
        [emptyView setReFreshBtnBackgroundColor:color];
    }
}

- (void)disPlayEmptyview:(UIView *)superView{
    [self disPlayEmptyview:superView imageName:nil tips:nil ishidden:YES color:nil];
}

- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips {
    [self disPlayEmptyview:superView image:image tips:tips backgroundColor:nil];
}

- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color {
    [self disPlayEmptyview:superView image:image tips:tips backgroundColor:color textFont:nil textColor:nil offset:0 ishidden:YES];
}

- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color
                textFont:(UIFont *)font {
    [self disPlayEmptyview:superView image:image tips:tips backgroundColor:color textFont:font textColor:nil offset:0 ishidden:YES];
}

- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color
                textFont:(UIFont *)font
               textColor:(UIColor *)textColor {
    [self disPlayEmptyview:superView image:image tips:tips backgroundColor:color textFont:font textColor:textColor offset:0 ishidden:YES];
}

- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color
                textFont:(UIFont *)font
               textColor:(UIColor *)textColor
                  offset:(CGFloat)y
                ishidden:(BOOL)ishidden {
    if (superView == nil) {
        superView = self.view;
    }
    [self removeEmptyView:superView];
    BaseEmptyView *emptyView = [[BaseEmptyView alloc] init];
    emptyView.tag = emptyViewTag;
    [superView addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
        if ([superView isKindOfClass:[UIScrollView class]]) {
            make.width.height.equalTo(superView);
        }
    }];
    if (image != nil) {
        [emptyView setImageEmpty:image];
    }
    if (IS_VALID_STRING(tips)) {
        [emptyView setTips:tips];
    }
    if (color != nil) {
        emptyView.backgroundColor = color;
    }
    if (font != nil) {
        emptyView.fontText = font;
    }
    if (textColor != nil) {
        emptyView.textColor = textColor;
    }
    [emptyView setIshidden:ishidden];
    [emptyView offSet:y];
}


- (void)removeEmptyView:(UIView *)superView {
    for (UIView *view in superView.subviews) {
        if (view.tag == emptyViewTag) {
            view.hidden = YES;
            [view removeFromSuperview];
            break;
        }
    }
}
#pragma mark 刷新控件初始化
- (void)initRefrehView:(UIScrollView *)scrollView {
    __weak typeof(self) weakSelf = self;
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadMoreData {
    self.loadDataIndex++;
    [self loadData];
}

- (void)loadNewData {
    self.loadDataIndex = 1;
    [self loadData];
}

- (void)loadData {
    
}
@end
