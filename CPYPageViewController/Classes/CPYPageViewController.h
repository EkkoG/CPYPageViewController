//
//  CPYPageViewController.h
//  Pods
//
//  Created by ciel on 2017/4/2.
//
//

#import <UIKit/UIKit.h>

@interface CPYPageViewController : UIViewController

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

- (void)selectViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
