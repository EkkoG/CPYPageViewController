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

@end

@protocol CPYPageViewControllerViewLifeCycle <NSObject>

@optional
- (void)cpy_pageViewWillAppear;
- (void)cpy_pageViewWillDisappear;

@end

@interface CPYPageViewController : UIViewController

@property (nonatomic, weak) id <CPYPageViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

// You can not modify the scrollView's delegate absolutly! Use scrollViewDelegate instead!
@property (nonatomic, strong, readonly) CPYScrollView *scrollView;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, weak) id <UIScrollViewDelegate> scrollViewDelegate;

- (void)selectViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
