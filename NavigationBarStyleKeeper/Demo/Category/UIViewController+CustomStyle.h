//
//  UIViewController+CustomStyle.h
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/18.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CustomStyle)

- (void)showWhiteStyle;
- (void)showCustomerBackgroundColor:(UIColor *)color;
- (void)showPrimerStyle;
- (void)pushWithAnimationFromBottom:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
