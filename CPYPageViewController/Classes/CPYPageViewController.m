//
//  CPYPageViewController.m
//  Pods
//
//  Created by ciel on 2017/4/2.
//
//

#import "CPYPageViewController.h"

@interface CPYPageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

@implementation CPYPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self __setup];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupViewControllers];
    [self setupScrollView];
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds) * self.selectedIndex, 0);
}

#pragma mark -setup

- (void)__setup {
    self.selectedIndex = 0;
    [self.view addSubview:self.scrollView];
    [self setupScrollView];
}

#pragma setters

- (void)selectViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
    self.selectedIndex = index;
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) * index, 0) animated:animated];
}

#pragma mark - public

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    [self setupViewControllers];
    [self setupScrollView];
}

#pragma mark - private

- (void)setupViewControllers {
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        [self addChildViewController:self.viewControllers[i]];
        [self.scrollView addSubview:self.viewControllers[i].view];
        self.viewControllers[i].view.frame = CGRectMake(i * CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        self.viewControllers[i].view.autoresizingMask = UIViewAutoresizingNone;
    }
}

- (void)setupScrollView {
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * self.viewControllers.count, CGRectGetHeight(self.view.bounds));
}

#pragma mark - getters

- (UIScrollView *)scrollView {
	if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
	}
	return _scrollView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didScrollToViewControllerAtIndex:)]) {
        self.selectedIndex = page;
        [self.delegate pageViewController:self didScrollToViewControllerAtIndex:page];
    }
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
