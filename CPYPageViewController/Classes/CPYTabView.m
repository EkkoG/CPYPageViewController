//
//  CPYTabView.m
//  Pods
//
//  Created by ciel on 2017/4/5.
//
//

#import "CPYTabView.h"

@interface CPYTabView ()

@property (nonatomic, strong) UIView *tabsContainerView;
@property (nonatomic, strong) UIView *floatingView;
@property (nonatomic, strong) NSArray <UIButton *> *tabButtons;

@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

@implementation CPYTabView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setup];
    }
    return self;
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tabsContainerView.frame = self.bounds;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setupTabs];
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
}

#pragma mark -setup

- (void)__setup {
    self.normalTitleColor = [UIColor blackColor];
    self.selectedTitileColor = [UIColor redColor];
    self.floatingViewColor = [UIColor yellowColor];
    self.titleFont = [UIFont systemFontOfSize:15];
    self.floatingViewHeight = 3;
    self.floatingViewWidth = -1;
    
    [self addSubview:self.tabsContainerView];
    self.tabsContainerView.frame = self.bounds;
    [self addSubview:self.floatingView];
}

- (void)setDataSource:(id<CPYTabViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self setupTabs];
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
}

#pragma public

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    self.selectedIndex = index;
    [self floatingViewMoveToIndex:index animated:animated];
}

- (void)reloadData {
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfTabs:)], @"the dataSource must implement dataSource methods");
    NSAssert([self.dataSource respondsToSelector:@selector(tabView:titleAtIndex:)], @"tabs must have title");
    
    [self setupTabs];
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    if (_normalTitleColor != normalTitleColor) {
        _normalTitleColor = normalTitleColor;
        [self setupTabs];
    }
}

- (void)setSelectedTitileColor:(UIColor *)selectedTitileColor {
    if (_selectedTitileColor != selectedTitileColor) {
        _selectedTitileColor = selectedTitileColor;
        [self setupTabs];
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
        [self setupTabs];
    }
}

- (void)setFloatingViewColor:(UIColor *)floatingViewColor {
    if (_floatingViewColor != floatingViewColor) {
        _floatingViewColor = floatingViewColor;
        self.floatingView.backgroundColor = floatingViewColor;
    }
}

- (void)setFloatingViewWidth:(CGFloat )floatingViewWidth {
    _floatingViewWidth = floatingViewWidth;
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
}

- (void)setFloatingViewHeight:(CGFloat )floatingViewHeight {
    _floatingViewHeight = floatingViewHeight;
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    self.tabButtons[_selectedIndex].selected = NO;
    
    _selectedIndex = selectedIndex;
    
    self.tabButtons[_selectedIndex].selected = YES;
}

#pragma mark - private

- (void)setupTabs {
    if (!self.dataSource) {
        return;
    }
    NSInteger count = [self.dataSource numberOfTabs:self];
    
    if (count == 0) {
        return;
    }
    
    for (UIView *v in self.tabsContainerView.subviews) {
        [v removeFromSuperview];
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [arr addObject:btn];
        btn.frame = CGRectMake(CGRectGetWidth(self.bounds) / count * i, 0, CGRectGetWidth(self.bounds) / count, CGRectGetHeight(self.bounds));
        [self.tabsContainerView addSubview:btn];
        
        NSString *titleString = [self.dataSource tabView:self titleAtIndex:i];
        [btn setTitle:titleString forState:UIControlStateNormal];
        btn.titleLabel.font = self.titleFont;
        [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTitileColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.dataSource respondsToSelector:@selector(tabView:backgroundImageAtIndex:)]) {
            UIImage *img = [self.dataSource tabView:self backgroundImageAtIndex:i];
            [btn setBackgroundImage:img forState:UIControlStateNormal];
        }
    }
    self.tabButtons = [arr copy];
    
    self.selectedIndex = 0;
}

- (void)tabClick:(UIButton *)sender {
    self.selectedIndex = [self.tabButtons indexOfObject:sender];
    [self floatingViewMoveToIndex:self.selectedIndex animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabView:didSelectedTabAtIndex:)]) {
        [self.delegate tabView:self didSelectedTabAtIndex:self.selectedIndex];
    }
}

- (void)setupFloatingView {
    if (!self.dataSource) {
        return;
    }
    
    NSInteger count = [self.dataSource numberOfTabs:self];
    if (count == 0) {
        return;
    }
    
    CGFloat width = self.floatingViewWidth > 0 ? self.floatingViewWidth : CGRectGetWidth(self.bounds) / count;
    self.floatingView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - self.floatingViewHeight, width, self.floatingViewHeight);
}

- (void)floatingViewMoveToIndex:(NSInteger)index animated:(BOOL)animated {
    if (!self.dataSource) {
        return;
    }
    
    NSInteger count = [self.dataSource numberOfTabs:self];
    if (count == 0) {
        return;
    }
    
    CGFloat averageWidth = CGRectGetWidth(self.bounds) / count;
    CGFloat leftX = averageWidth * index + averageWidth / 2 - CGRectGetWidth(self.floatingView.bounds) / 2;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.floatingView.frame;
            f.origin.x = leftX;
            self.floatingView.frame = f;
        }];
    }
    else {
        CGRect f = self.floatingView.frame;
        f.origin.x = leftX;
        self.floatingView.frame = f;
    }
}

#pragma mark - getters

- (UIView *)tabsContainerView {
	if (!_tabsContainerView) {
        _tabsContainerView = [[UIView alloc] init];
	}
	return _tabsContainerView;
}

- (UIView *)floatingView {
	if (!_floatingView) {
        _floatingView = [[UIView alloc] init];
	}
	return _floatingView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
