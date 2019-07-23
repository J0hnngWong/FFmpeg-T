//
//  UIViewController+CustomStyle.m
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/18.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import "UIViewController+CustomStyle.h"

@interface UIViewController ()

@end

@implementation UIViewController (CustomStyle)

- (void)showWhiteStyle
{
    if (!self.navigationController) {
        return;
    }
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)showCustomerBackgroundColor:(UIColor *)color
{
    if (!self.navigationController) {
        return;
    }
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)showPrimerStyle
{
    if (!self.navigationController) {
        return;
    }
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)pushWithAnimationFromBottom:(UIViewController *)viewController
{
    if (!self.navigationController) {
        return;
    }
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:viewController animated:NO];
}

@end
