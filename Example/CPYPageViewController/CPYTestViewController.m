//
//  CPYTestViewController.m
//  CPYPageViewController
//
//  Created by ciel on 2017/6/29.
//  Copyright © 2017年 cielpy. All rights reserved.
//

#import "CPYTestViewController.h"
#import <CPYPageViewController/CPYPageViewController.h>

@interface CPYTestViewController () <CPYPageViewControllerViewLifeCycle>

@end

@implementation CPYTestViewController

- (void)cpy_pageViewWillDisappear {
    NSLog(@"%ld view will disappear.", self.index);
}

- (void)cpy_pageViewWillAppear {
    NSLog(@"%ld view will appear.", self.index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
