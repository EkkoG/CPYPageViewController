//
//  CPYTabedPageViewController.h
//  Pods
//
//  Created by ciel on 2017/4/6.
//
//

#import <UIKit/UIKit.h>
#import "CPYPageViewController.h"
#import "CPYTabView.h"

@class CPYTabedPageViewController;

@protocol CPYTabedPageViewControllerDelegate <NSObject>

- (void)tabedPageViewController:(CPYTabedPageViewController *)pageViewController didSelectedViewControllerAtIndex:(NSInteger)index;

@end

@interface CPYTabedPageViewController : UIViewController

@property (nonatomic, strong) NSArray <UIViewController *> *viewControllers;
@property (nonatomic, strong) NSArray <CPYTabItem *> *tabItems;

@property (nonatomic, strong, readonly) CPYPageViewController *pageViewController;
@property (nonatomic, strong, readonly) CPYTabView *tabView;

@property (nonatomic, assign) CGFloat tabHeight;
@property (nonatomic, strong) NSArray <UIColor *>*floatingViewColors;
@property (nonatomic, strong) UIColor *floatingViewColor;
@property (nonatomic, assign) CGFloat floatingViewWidth;
@property (nonatomic, assign) CGFloat floatingViewHeight;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, weak) id <CPYTabedPageViewControllerDelegate> delegate;

- (void)reloadData;

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
