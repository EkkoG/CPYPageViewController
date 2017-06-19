//
//  CPYPageViewController.h
//  Pods
//
//  Created by ciel on 2017/4/2.
//
//

#import <UIKit/UIKit.h>
#import "CPYScrollView.h"

@class CPYPageViewController;

@protocol CPYPageViewControllerDelegate <NSObject>

- (void)pageViewController:(CPYPageViewController *)pageViewController didScrollToViewControllerAtIndex:(NSInteger)index;

@optional
- (void)pageViewController:(CPYPageViewController *)pageViewController didScrollToContentOffset:(CGPoint)contentOffset;

@end

@interface CPYPageViewController : UIViewController

@property (nonatomic, weak) id <CPYPageViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, strong, readonly) CPYScrollView *scrollView;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)selectViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
