//
//  CPYTabedPageViewController.m
//  Pods
//
//  Created by ciel on 2017/4/6.
//
//

#import "CPYTabedPageViewController.h"

@interface CPYTabedPageViewController () <CPYTabViewDataSource, CPYTabViewDelegate, CPYPageViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) CPYPageViewController *pageViewController;
@property (nonatomic, strong, readwrite) CPYTabView *tabView;

@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

@implementation CPYTabedPageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tabHeight = 44;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self __setup];
    [self setupTabView];
    [self setupPageViewController];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupTabView];
    [self setupPageViewController];
}

#pragma mark - setup

- (void)__setup {
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.tabView];
    [self.view addSubview:self.pageViewController.view];
    
}

#pragma mark - public

- (void)reloadData {
    [self.tabView reloadData];
}

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    [self.tabView selectTabAtIndex:index animated:animated];
    [self.pageViewController selectViewControllerAtIndex:index animated:animated];
}

#pragma mark - setters

- (void)setTabHeight:(CGFloat)tabHeight {
    _tabHeight = tabHeight;
    [self setupTabView];
    [self setupPageViewController];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    if (_viewControllers != viewControllers) {
        _viewControllers = viewControllers;
        self.pageViewController.viewControllers = viewControllers;
        [self.tabView reloadData];
    }
}

- (void)setTabItems:(NSArray<CPYTabItem *> *)tabItems {
    _tabItems = tabItems;
    NSAssert(self.viewControllers.count > 0, @"Please set viewControllers first.");
    NSAssert(self.viewControllers.count == tabItems.count, @"TabItems count must equal to viewControllers count.");
    [self.tabView reloadData];
}

- (void)setFloatingViewColor:(UIColor *)floatingViewColor {
    if (_floatingViewColor != floatingViewColor) {
        _floatingViewColor = floatingViewColor;
        self.tabView.floatingViewColor = floatingViewColor;
    }
}

- (void)setFloatingViewWidth:(CGFloat)floatingViewWidth {
    _floatingViewWidth = floatingViewWidth;
    self.tabView.floatingViewWidth = floatingViewWidth;
}

- (void)setFloatingViewHeight:(CGFloat)floatingViewHeight {
    _floatingViewHeight = floatingViewHeight;
    self.tabView.floatingViewHeight = floatingViewHeight;
}

#pragma mark - getters

- (CPYPageViewController *)pageViewController {
	if (!_pageViewController) {
        _pageViewController = [[CPYPageViewController alloc] init];
        _pageViewController.delegate = self;
        _pageViewController.scrollViewDelegate = self;
	}
	return _pageViewController;
}

- (CPYTabView *)tabView {
	if (!_tabView) {
        _tabView = [[CPYTabView alloc] init];
        _tabView.dataSource = self;
        _tabView.delegate = self;
	}
	return _tabView;
}

#pragma mark - CPYTabViewDatasource

- (NSInteger)numberOfTabs:(CPYTabView *)tabView {
    return self.viewControllers.count;
}

- (CPYTabItem *)tabView:(CPYTabView *)tabView tabItemAtIndex:(NSInteger)index {
    return self.tabItems[index];
}

#pragma mark - CPYTabViewDelegate

- (void)tabView:(CPYTabView *)tabView didSelectedTabAtIndex:(NSInteger)index {
    [self.pageViewController selectViewControllerAtIndex:index animated:YES];
    self.selectedIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabedPageViewController:didSelectedViewControllerAtIndex:)]) {
        [self.delegate tabedPageViewController:self didSelectedViewControllerAtIndex:index];
    }
}

#pragma mark - CPYPageViewControllerDelegate

- (void)pageViewController:(CPYPageViewController *)pageViewController didScrollToViewControllerAtIndex:(NSInteger)index {
    [self.tabView selectTabAtIndex:index animated:YES];
    self.selectedIndex = index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabedPageViewController:didSelectedViewControllerAtIndex:)]) {
        [self.delegate tabedPageViewController:self didSelectedViewControllerAtIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x - self.pageViewController.selectedIndex * CGRectGetWidth(self.view.bounds);
    self.tabView.floatingViewExpandScale = x / CGRectGetWidth(self.view.bounds);
}

#pragma mark - private

- (void)setupTabView {
    self.tabView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.tabHeight);
}

- (void)setupPageViewController {
    self.pageViewController.view.frame = CGRectMake(0, self.tabHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.tabHeight);
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
