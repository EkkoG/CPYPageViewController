//
//  CPYTabView.h
//  Pods
//
//  Created by ciel on 2017/4/5.
//
//

#import <UIKit/UIKit.h>

@interface CPYTabItem : NSObject

@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitileColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, copy) NSString *title;

- (instancetype)initItemWithTitle:(NSString *)title;
- (instancetype)initItemWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor;
- (instancetype)initItemWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage;
- (instancetype)initItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage;

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

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)reloadData;

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
