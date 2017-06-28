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
    return [self initItemWithTitle:title titleFont:titleFont selectedTitileFont:titleFont normalTitleColor:normalTitleColor selectedTitleColor:selectedTitleColor normalBackgroundImage:normalBackgroundImage selectedBackgroundImage:selectedBackgroundImage];
}

- (instancetype)initItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont selectedTitileFont:(UIFont *)selectedTitleFont normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBackgroundImage:(UIImage *)normalBackgroundImage selectedBackgroundImage:(UIImage *)selectedBackgroundImage {
    self = [super init];
    if (self) {
        _title = [title copy];
        _titleFont = titleFont;
        _selectedTitleFont = selectedTitleFont;
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
@property (nonatomic, strong, readwrite) UIView *bottomLineView;
@property (nonatomic, strong) NSArray <UIButton *> *tabButtons;

@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

@implementation CPYTabView

- (void)dealloc {
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __setup];
    }
    return self;
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    self.floatingView.layer.cornerRadius = CGRectGetHeight(self.floatingView.bounds) / 2.0f;
    self.floatingView.clipsToBounds = YES;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.tabsContainerView.frame = self.bounds;
    [self layoutTabs];
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
    self.bottomLineView.frame = CGRectMake(0, CGRectGetHeight(frame) - 0.5, CGRectGetWidth(frame), 0.5);
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.tabsContainerView.frame = self.bounds;
    [self layoutTabs];
    [self setupFloatingView];
    [self floatingViewMoveToIndex:self.selectedIndex animated:NO];
    self.bottomLineView.frame = CGRectMake(0, CGRectGetHeight(bounds) - 0.5, CGRectGetWidth(bounds), 0.5);
}

#pragma mark -setup

- (void)__setup {
    self.floatingViewColor = [UIColor yellowColor];
    self.floatingViewHeight = 3;
    self.floatingViewWidth = -1;
    self.selectedIndex = 0;
    self.floatingViewBottomMargin = 0;
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tabsContainerView];
    self.tabsContainerView.frame = self.bounds;
    [self addSubview:self.floatingView];
    
    [self addSubview:self.bottomLineView];
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.tabsContainerView.frame = strongSelf.bounds;
        [strongSelf layoutTabs];
        [strongSelf setupFloatingView];
        [strongSelf floatingViewMoveToIndex:strongSelf.selectedIndex animated:NO];
        strongSelf.bottomLineView.frame = CGRectMake(0, CGRectGetHeight(strongSelf.bounds) - 0.5, CGRectGetWidth(strongSelf.bounds), 0.5);
    }];
}

- (void)setDataSource:(id<CPYTabViewDataSource>)dataSource {
    NSAssert([dataSource respondsToSelector:@selector(numberOfTabs:)], @"the dataSource must implement dataSource methods");
    
    _dataSource = dataSource;
    
    [self setupTabs];
    [self layoutTabs];
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
    [self layoutTabs];
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

- (void)setFloatingViewBottomMargin:(CGFloat)floatingViewBottomMargin {
    _floatingViewBottomMargin = floatingViewBottomMargin;
    
    [self setupFloatingView];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    NSInteger count = [self.dataSource numberOfTabs:self];
    
    if (count == 0) {
        return;
    }
    
    self.tabButtons[_selectedIndex].selected = NO;
    CPYTabItem *item = [self.dataSource tabView:self tabItemAtIndex:_selectedIndex];
    self.tabButtons[_selectedIndex].titleLabel.font = item.titleFont;
    
    _selectedIndex = selectedIndex;
    
    CPYTabItem *item1 = [self.dataSource tabView:self tabItemAtIndex:_selectedIndex];
    self.tabButtons[_selectedIndex].titleLabel.font = item1.selectedTitleFont;
    
    self.tabButtons[_selectedIndex].selected = YES;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    if (_bottomLineColor != bottomLineColor) {
        _bottomLineColor = bottomLineColor;
        self.bottomLineView.backgroundColor = bottomLineColor;
    }
}

- (void)setFloatingViewExpand:(BOOL)floatingViewExpand {
    _floatingViewExpand = floatingViewExpand;
}


- (void)setFloatingViewExpandScale:(CGFloat)floatingViewExpandScale {
    _floatingViewExpandScale = floatingViewExpandScale;
    [self expandFloatingView];
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
    
    if (self.floatingViewWidth < 0) {
        self.floatingViewWidth = CGRectGetWidth([UIScreen mainScreen].bounds) / count;
    }
    
    self.floatingView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - self.floatingViewHeight - self.floatingViewBottomMargin, self.floatingViewWidth, self.floatingViewHeight);
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
    CGFloat leftX = averageWidth * index + averageWidth / 2 - self.floatingViewWidth / 2;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.floatingView.frame;
            f.origin.x = leftX;
            f.size.width = self.floatingViewWidth;
            self.floatingView.frame = f;
        }];
    }
    else {
        CGRect f = self.floatingView.frame;
        f.origin.x = leftX;
        f.size.width = self.floatingViewWidth;
        self.floatingView.frame = f;
    }
}

- (void)layoutTabs {
    NSArray *arr = self.tabButtons;
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = arr[i];
        btn.frame = CGRectMake(CGRectGetWidth(self.bounds) / arr.count * i, 0, CGRectGetWidth(self.bounds) / arr.count, CGRectGetHeight(self.bounds));
    }
}

- (void)expandFloatingView {
    if (!self.floatingViewExpand) {
        return;
    }
    
    NSInteger count = [self.dataSource numberOfTabs:self];
    if (count == 0) {
        return;
    }
    
    CGFloat averageWidth = CGRectGetWidth(self.bounds) / count;
    CGRect f = self.floatingView.frame;
    f.size.width = self.floatingViewWidth * (1 + self.floatingViewExpandScale);
    
    CGFloat leftX = averageWidth * self.selectedIndex + averageWidth / 2 - CGRectGetWidth(f) / 2;
    f.origin.x = leftX;
    
    self.floatingView.frame = f;
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


- (UIView *)bottomLineView {
	if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor blackColor];
	}
	return _bottomLineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
