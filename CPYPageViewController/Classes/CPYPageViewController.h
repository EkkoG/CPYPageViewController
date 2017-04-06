//
//  CPYPageViewController.h
//  Pods
//
//  Created by ciel on 2017/4/2.
//
//

#import <UIKit/UIKit.h>

@class CPYPageViewController;

@protocol CPYPageViewControllerDelegate <NSObject>

- (void)pageViewController:(CPYPageViewController *)pageViewController didScrollToViewControllerAtIndex:(NSInteger)index;

@end

@interface CPYPageViewController : UIViewController

@property (nonatomic, weak) id <CPYPageViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

- (void)selectViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
