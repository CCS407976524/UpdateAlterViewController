//
//  BaseViewController.h
//  findcar
//
//  Created by hongjunjia on 15/9/5.
//  Copyright (c) 2015年 hongjunjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYBase/TYMacro_common.h>

static NSInteger emptyViewTag = 3233;
@interface BaseViewController : UIViewController<UINavigationControllerDelegate>

//下拉刷新和加载更多控件默认初始化
@property (assign, nonatomic) NSInteger loadDataIndex;
- (void)loadMoreData;
- (void)loadNewData;
- (void)loadData;

- (BOOL)isVisible;
- (void)registerKeyboardEvent;
- (void)unregisterKeyboardEvent;

/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView
               imageName:(NSString *)name
                    tips:(NSString *)tips
                ishidden:(BOOL)ishidden
                   color:(UIColor *)color TYBaseDeprecated("已过期");
/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView
               imageName:(NSString *)name
                    tips:(NSString *)tips TYBaseDeprecated("已过期，请使用disPlayEmptyview:image:tips");
/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips;
/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color;
/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color
                textFont:(UIFont *)font;
/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView
                   image:(UIImage *)image
                    tips:(NSString *)tips
         backgroundColor:(UIColor *)color
                textFont:(UIFont *)font
               textColor:(UIColor *)textColor
                  offset:(CGFloat)y
                ishidden:(BOOL)ishidden;
/**空数据界面显示*/
- (void)disPlayEmptyview:(UIView *)superView;
/**空数据界面移除*/
- (void)removeEmptyView:(UIView *)superView;

- (void)initRefrehView:(UIScrollView *)scrollView;
@end
