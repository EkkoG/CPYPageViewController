//
//  CPYTabedPageViewController.m
//  Pods
//
//  Created by ciel on 2017/4/6.
//
//

#import "CPYTabedPageViewController.h"
#import "CPYPageViewController.h"
#import "CPYTabView.h"

@interface CPYTabedPageViewController () <CPYTabViewDataSource, CPYTabViewDelegate, CPYPageViewControllerDelegate>

@property (nonatomic, strong) CPYPageViewController *pageViewController;
@property (nonatomic, strong) CPYTabView *tabView;

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
}

- (void)__setup {
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.tabView];
    [self.view addSubview:self.pageViewController.view];
    
}

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


- (void)setTitles:(NSArray<NSString *> *)titles {
    if (_titles != titles) {
        _titles = titles;
        [self.tabView reloadData];
    }
}

- (void)setBackgroundImages:(NSArray<UIImage *> *)backgroundImages {
    if (_backgroundImages != backgroundImages) {
        _backgroundImages = backgroundImages;
        [self.tabView reloadData];
    }
}


- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    if (_normalTitleColor != normalTitleColor) {
        _normalTitleColor = normalTitleColor;
        self.tabView.normalTitleColor = normalTitleColor;
    }
}

- (void)setSelectedTitileColor:(UIColor *)selectedTitileColor {
    if (_selectedTitileColor != selectedTitileColor) {
        _selectedTitileColor = selectedTitileColor;
        self.tabView.selectedTitileColor = selectedTitileColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
        self.tabView.titleFont = titleFont;
    }
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

- (NSString *)tabView:(CPYTabView *)tabView titleAtIndex:(NSInteger)index {
    if (index > self.titles.count - 1) {
        return nil;
    }
    return self.titles[index];
}

- (UIImage *)tabView:(CPYTabView *)tabView backgroundImageAtIndex:(NSInteger)index {
    if (index > self.backgroundImages.count - 1) {
        return nil;
    }
    return self.backgroundImages[index];
}

#pragma mark - CPYTabViewDelegate

- (void)tabView:(CPYTabView *)tabView didSelectedTabAtIndex:(NSInteger)index {
    [self.pageViewController selectViewControllerAtIndex:index animated:YES];
    self.selectedIndex = index;
}

#pragma mark - CPYPageViewControllerDelegate

- (void)pageViewController:(CPYPageViewController *)pageViewController didScrollToViewControllerAtIndex:(NSInteger)index {
    [self.tabView selectTabAtIndex:index animated:YES];
    self.selectedIndex = index;
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
