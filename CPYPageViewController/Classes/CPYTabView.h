//
//  CPYTabView.h
//  Pods
//
//  Created by ciel on 2017/4/5.
//
//

#import <UIKit/UIKit.h>

@interface CPYButton : UIButton

@end

@interface CPYTabItem : NSObject

@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitileColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *selectedTitleFont;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGFloat shadowOpacity;

- (instancetype)initItemWithTitle:(NSString *)title;
- (instancetype)initItemWithNormalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage;
- (instancetype)initItemWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor;
- (instancetype)initItemWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage;
- (instancetype)initItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage;
- (instancetype)initItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont selectedTitileFont:(UIFont *)selectedTitleFont normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage;

@end

@class CPYTabView;

@protocol CPYTabViewDataSource <NSObject>

- (NSInteger)numberOfTabs:(CPYTabView *)tabView;

@optional
- (CPYTabItem *)tabView:(CPYTabView *)tabView tabItemAtIndex:(NSInteger)index;

@end

@protocol CPYTabViewDelegate <NSObject>

- (void)tabView:(CPYTabView *)tabView didSelectedTabAtIndex:(NSInteger)index;

@end

@interface CPYTabView : UIView

@property (nonatomic, weak) id <CPYTabViewDataSource> dataSource;
@property (nonatomic, weak) id <CPYTabViewDelegate> delegate;

@property (nonatomic, strong) UIColor *floatingViewColor;
@property (nonatomic, assign) CGFloat floatingViewWidth;
@property (nonatomic, assign) CGFloat floatingViewHeight;
@property (nonatomic, assign) CGFloat floatingViewBottomMargin;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, assign) BOOL floatingViewExpand;
@property (nonatomic, assign) CGFloat floatingViewExpandScale;

@property (nonatomic, strong, readonly) UIView *bottomLineView;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)reloadData;

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
