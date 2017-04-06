//
//  CPYTabedPageViewController.h
//  Pods
//
//  Created by ciel on 2017/4/6.
//
//

#import <UIKit/UIKit.h>

@interface CPYTabedPageViewController : UIViewController

@property (nonatomic, strong) NSArray <UIViewController *> *viewControllers;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <UIImage *> *backgroundImages;

@property (nonatomic, assign) CGFloat tabHeight;
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
