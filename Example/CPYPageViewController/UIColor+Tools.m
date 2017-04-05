//
//  UIColor+Tools.m
//  CPYPageViewController
//
//  Created by ciel on 2017/4/5.
//  Copyright © 2017年 cielpy. All rights reserved.
//

#import "UIColor+Tools.h"

@implementation UIColor (Tools)

+ (UIColor *)randomColor{
    return [self R:arc4random()%255 G:arc4random()%255 B:arc4random()%255];
}

+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b{
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

@end
