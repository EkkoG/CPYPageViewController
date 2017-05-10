//
//  CPYTabView.m
//  Pods
//
//  Created by ciel on 2017/4/5.
//
//

#import "CPYTabView.h"

@implementation CPYTabItem

- (instancetype)initItemWithTitle:(NSString *)title
{
    return [self initItemWithTitle:title titleFont:[UIFont systemFontOfSize:15] normalTitleColor:[UIColor blackColor] selectedTitleColor:[UIColor redColor] normalBackgroundImage:nil selectedBackgroundImage:nil];
}

- (instancetype)initItemWithNormalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    return [self initItemWithTitle:nil normalTitleColor:nil selectedTitleColor:nil normalBackgroundImage:normalBackgroundImage selectedBackgroundImage:selectedBackgroundImage];
}

- (instancetype)initItemWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor
{
    return [self initItemWithTitle:title titleFont:[UIFont systemFontOfSize:15] normalTitleColor:normalTitleColor selectedTitleColor:selectedTitleColor normalBackgroundImage:nil selectedBackgroundImage:nil];
}

- (instancetype)initItemWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    return [self initItemWithTitle:title titleFont:[UIFont systemFontOfSize:15] normalTitleColor:normalTitleColor selectedTitleColor:selectedTitleColor normalBackgroundImage:normalBackgroundImage selectedBackgroundImage:selectedBackgroundImage];
}

- (instancetype)initItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _titleFont = titleFont;
        _normalTitleColor = normalTitleColor;
        _selectedTitileColor = selectedTitleColor;
        _normalBackgroundImage = normalBackgroundImage;
        _selectedBackgroundImage = selectedBackgroundImage;
    }
    return self;
}

@end

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
    self.selectedIndex = 0;
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
}

#pragma mark -setup

- (void)__setup {
    self.floatingViewColor = [UIColor yellowColor];
    self.floatingViewHeight = 3;
    self.floatingViewWidth = -1;
    self.selectedIndex = 0;
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tabsContainerView];
    self.tabsContainerView.frame = self.bounds;
    [self addSubview:self.floatingView];
}

- (void)setDataSource:(id<CPYTabViewDataSource>)dataSource {
    NSAssert([dataSource respondsToSelector:@selector(numberOfTabs:)], @"the dataSource must implement dataSource methods");
    
    _dataSource = dataSource;
    
    [self setupTabs];
    self.selectedIndex = 0;
    [self setupFloatingView];
    [self floatingViewMoveToIndex:0 animated:NO];
}

#pragma public

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    self.selectedIndex = index;
    [self floatingViewMoveToIndex:index animated:animated];
}

- (void)reloadData {
    [self setupTabs];
    self.selectedIndex = 0;
    [self setupFloatingView];
    [self floatingViewMoveToIndex:0 animated:NO];
}

- (void)setFloatingViewColor:(UIColor *)floatingViewColor {
    if (_floatingViewColor != floatingViewColor) {
        _floatingViewColor = floatingViewColor;
        self.floatingView.backgroundColor = floatingViewColor;
    }
}

- (void)setFloatingViewColors:(NSArray<UIColor *> *)floatingViewColors {
    _floatingViewColors = floatingViewColors;
    self.floatingView.backgroundColor = floatingViewColors.firstObject;
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
        
        [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.dataSource respondsToSelector:@selector(tabView:tabItemAtIndex:)]) {
            CPYTabItem *item = [self.dataSource tabView:self tabItemAtIndex:i];
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setBackgroundImage:item.normalBackgroundImage forState:UIControlStateNormal];
            [btn setTitleColor:item.normalTitleColor forState:UIControlStateNormal];
            
            [btn setBackgroundImage:item.selectedBackgroundImage forState:UIControlStateSelected];
            [btn setTitleColor:item.selectedTitileColor forState:UIControlStateSelected];
            btn.titleLabel.font = item.titleFont;
        }
    }
    self.tabButtons = [arr copy];
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
    
    if (self.floatingViewColors && self.floatingViewColors.count != count) {
        return;
    }
    
    if (self.floatingViewColors) {
        self.floatingView.backgroundColor = self.floatingViewColors[index];
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
