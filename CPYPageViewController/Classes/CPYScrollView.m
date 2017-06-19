//
//  CPYScrollView.m
//  Pods
//
//  Created by ciel on 2017/6/19.
//
//

#import "CPYScrollView.h"

@implementation CPYScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _enableRightGestureAtFirstPage = YES;
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([self panBack:gestureRecognizer] && self.enableRightGestureAtFirstPage) {
        return YES;
    }
    return NO;
    
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            if (point.x > 0 && location.x < CGRectGetWidth(self.bounds) && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([self panBack:gestureRecognizer] && self.enableRightGestureAtFirstPage) {
        return NO;
    }
    return YES;
}

@end
