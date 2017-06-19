//
//  CPYScrollView.h
//  Pods
//
//  Created by ciel on 2017/6/19.
//
//

#import <UIKit/UIKit.h>

@interface CPYScrollView : UIScrollView


/**
 To disable the pan gesture at first page, default value is YES
 You can use this option to diable the pan gesture, to allow the scroll view delivery the gesture to another view.
 */
@property (nonatomic, assign) BOOL enableRightGestureAtFirstPage;

@end
