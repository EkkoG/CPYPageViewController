//
//  CPYViewController.m
//  CPYPageViewController
//
//  Created by cielpy on 04/02/2017.
//  Copyright (c) 2017 cielpy. All rights reserved.
//

#import "CPYViewController.h"
#import <CPYPageViewController/CPYPageViewController.h>
#import "UIColor+Tools.h"

@interface CPYViewController ()

@end

@implementation CPYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CPYPageViewController *page = [[CPYPageViewController alloc] init];
    [self addChildViewController:page];
    [self.view addSubview:page.view];
    page.view.frame = self.view.bounds;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor randomColor];
        [arr addObject:vc];
    }
    page.viewControllers = [arr copy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
