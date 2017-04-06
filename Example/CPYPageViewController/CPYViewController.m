//
//  CPYViewController.m
//  CPYPageViewController
//
//  Created by cielpy on 04/02/2017.
//  Copyright (c) 2017 cielpy. All rights reserved.
//

#import "CPYViewController.h"
#import <CPYPageViewController/CPYPageViewController.h>
#import <CPYPageViewController/CPYTabView.h>
#import "UIColor+Tools.h"

@interface CPYViewController () <CPYTabViewDataSource>

@end

@implementation CPYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CPYTabView *tab = [[CPYTabView alloc] init];
    tab.backgroundColor = [UIColor grayColor];
    tab.dataSource = self;
    tab.normalTitleColor = [UIColor randomColor];
    tab.selectedTitileColor = [UIColor randomColor];
    tab.titleFont = [UIFont systemFontOfSize:18];
    tab.floatingViewColor = [UIColor randomColor];
    [self.view addSubview:tab];
    tab.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50);
    tab.floatingViewHeight = 5;
}

- (NSInteger)numberOfTabs:(CPYTabView *)tabView {
    return 4;
}

- (NSString *)tabView:(CPYTabView *)tabView titleAtIndex:(NSInteger)index {
    return @"ahh";
}

- (UIImage *)tabView:(CPYTabView *)tabView backgroundImageAtIndex:(NSInteger)index {
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
