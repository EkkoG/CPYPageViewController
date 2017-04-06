//
//  CPYTabView.h
//  Pods
//
//  Created by ciel on 2017/4/5.
//
//

#import <UIKit/UIKit.h>

@class CPYTabView;

@protocol CPYTabViewDataSource <NSObject>

- (NSInteger)numberOfTabs:(CPYTabView *)tabView;

@optional
- (NSString *)tabView:(CPYTabView *)tabView titleAtIndex:(NSInteger)index;
- (UIImage *)tabView:(CPYTabView *)tabView backgroundImageAtIndex:(NSInteger)index;

@end

@protocol CPYTabViewDelegate <NSObject>

- (void)tabView:(CPYTabView *)tabView didSelectedTabAtIndex:(NSInteger)index;

@end

@interface CPYTabView : UIView

@property (nonatomic, weak) id <CPYTabViewDataSource> dataSource;
@property (nonatomic, weak) id <CPYTabViewDelegate> delegate;

@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitileColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *floatingViewColor;
@property (nonatomic, assign) CGFloat floatingViewWidth;
@property (nonatomic, assign) CGFloat floatingViewHeight;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)reloadData;

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
