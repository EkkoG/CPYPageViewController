//
//  CPYViewController.m
//  CPYPageViewController
//
//  Created by cielpy on 04/02/2017.
//  Copyright (c) 2017 cielpy. All rights reserved.
//

#import "CPYViewController.h"
#import <CPYPageViewController/CPYTabedPageViewController.h>
#import "UIColor+Tools.h"
#import "CPYTestViewController.h"

@interface CPYViewController () <CPYTabedPageViewControllerDelegate>

@property (nonatomic, strong) CPYTabedPageViewController *tabedPageViewController;

@end

@implementation CPYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (void)setup {
    [self addChildViewController:self.tabedPageViewController];
    [self.view addSubview:self.tabedPageViewController.view];
    self.tabedPageViewController.view.frame = self.view.bounds;
    
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        CPYTestViewController *vc = [[CPYTestViewController alloc] init];
        vc.index = i;
        vc.view.backgroundColor = [UIColor randomColor];
        [vcs addObject:vc];
        CPYTabItem *item = [[CPYTabItem alloc] initItemWithTitle:[NSString stringWithFormat:@"%d", i] normalTitleColor:[UIColor blackColor] selectedTitleColor:[UIColor randomColor]];
        item.selectedTitleFont = [UIFont systemFontOfSize:20];
        item.shadowColor = [UIColor blueColor];
        item.shadowOffset = CGSizeMake(0, 3);
        item.shadowOpacity = 1;
        [items addObject:item];
    }
    self.tabedPageViewController.viewControllers = [vcs copy];
    self.tabedPageViewController.tabItems = [items copy];
    self.tabedPageViewController.tabView.floatingViewExpand = YES;
    self.tabedPageViewController.floatingViewWidth = 15;
    self.tabedPageViewController.floatingViewColor = [UIColor redColor];
}


- (CPYTabedPageViewController *)tabedPageViewController {
	if (!_tabedPageViewController) {
        _tabedPageViewController = [[CPYTabedPageViewController alloc] init];
        _tabedPageViewController.tabHeight = 80;
        _tabedPageViewController.delegate = self;
	}
	return _tabedPageViewController;
}

- (void)tabedPageViewController:(CPYTabedPageViewController *)pageViewController didSelectedViewControllerAtIndex:(NSInteger)index {
    NSLog(@"tabed selected %ld", index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
