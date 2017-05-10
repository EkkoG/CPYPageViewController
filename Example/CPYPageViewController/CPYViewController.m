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

@interface CPYViewController ()

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
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor randomColor];
        [vcs addObject:vc];
        CPYTabItem *item = [[CPYTabItem alloc] initItemWithTitle:[NSString stringWithFormat:@"%d", i] normalTitleColor:[UIColor blackColor] selectedTitleColor:[UIColor randomColor]];
        [items addObject:item];
    }
    self.tabedPageViewController.floatingViewColors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blueColor], [UIColor grayColor]];
    self.tabedPageViewController.viewControllers = [vcs copy];
    self.tabedPageViewController.tabItems = [items copy];
}


- (CPYTabedPageViewController *)tabedPageViewController {
	if (!_tabedPageViewController) {
        _tabedPageViewController = [[CPYTabedPageViewController alloc] init];
        _tabedPageViewController.tabHeight = 80;
	}
	return _tabedPageViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
