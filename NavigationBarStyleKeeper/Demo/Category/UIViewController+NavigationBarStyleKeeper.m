//
//  UIViewController+NavigationBarStyleKeeper.m
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/24.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import "UIViewController+NavigationBarStyleKeeper.h"
#import <objc/runtime.h>

NSString const * navigationBarTitleTextAttributeKey = @"navigationBarTitleTextAttribute";
NSString const * navigationBarBarTintColorKey = @"navigationBarBarTintColor";
NSString const * navigationBarTintColorKey = @"navigationBarTintColor";
NSString const * navigationBarShadowImageKey = @"navigationBarShadowImage";
NSString const * navigationBarBackgroundImageForDefaultBarMetricsKey = @"navigationBarBackgroundImageForDefaultBarMetrics";
NSString const * navigationBarTranslucentKey = @"navigationBarTranslucent";

@interface UIViewController ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *navigationBarPropertyDictionary;

@end

@implementation UIViewController (NavigationBarStyleKeeper)

+ (void)load
{
    Method viewDidAppearOriginal = class_getInstanceMethod(self, @selector(viewDidAppear:));
    Method viewDidAppearSaveNavigationBarStyle = class_getInstanceMethod(self, @selector(viewDidAppearSaveNavigationBarStyle:));
    
    Method viewWillAppearOriginal = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method viewWillAppearRestoreNavigationBarStyle = class_getInstanceMethod(self, @selector(viewWillAppearRestoreNavigationBarStyle:));
    
    method_exchangeImplementations(viewDidAppearOriginal, viewDidAppearSaveNavigationBarStyle);
    method_exchangeImplementations(viewWillAppearOriginal, viewWillAppearRestoreNavigationBarStyle);
}

- (void)viewDidAppearSaveNavigationBarStyle:(BOOL)animated
{
    if (self.navigationBarPropertyDictionary == nil) {
        self.navigationBarPropertyDictionary = [[NSMutableDictionary alloc] init];
    }
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    // save navigation bar style
    if (self.navigationController) {
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.titleTextAttributes copy] forKey:navigationBarTitleTextAttributeKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.barTintColor copy] forKey:navigationBarBarTintColorKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.tintColor copy] forKey:navigationBarTintColorKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.shadowImage copy] forKey:navigationBarShadowImageKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] copy] forKey:navigationBarBackgroundImageForDefaultBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@(self.navigationController.navigationBar.translucent) forKey:navigationBarTranslucentKey];
    }
    [self viewDidAppearSaveNavigationBarStyle:animated];
}

- (void)viewWillAppearRestoreNavigationBarStyle:(BOOL)animated
{
//    for (UIViewController *viewController in self.navigationController.viewControllers) {
//        NSLog(@"++++++++++%@+++++++++++++", viewController);
//        [viewController.navigationBarPropertyDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            NSLog(@"key : %@------obj : %@", key, obj);
//        }];
//    }
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // restore navigation bar style
    if (self.navigationBarPropertyDictionary && self.navigationController) {
        // only pop to this controller will pass this condition check
        self.navigationController.navigationBar.titleTextAttributes = [self.navigationBarPropertyDictionary objectForKey:navigationBarTitleTextAttributeKey];
        self.navigationController.navigationBar.barTintColor = [self.navigationBarPropertyDictionary objectForKey:navigationBarBarTintColorKey];
        self.navigationController.navigationBar.tintColor = [self.navigationBarPropertyDictionary objectForKey:navigationBarTintColorKey];
        self.navigationController.navigationBar.shadowImage = [self.navigationBarPropertyDictionary objectForKey:navigationBarShadowImageKey];
        [self.navigationController.navigationBar setBackgroundImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackgroundImageForDefaultBarMetricsKey] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = [[self.navigationBarPropertyDictionary objectForKey:navigationBarTranslucentKey] boolValue];
    }
    [self viewWillAppearRestoreNavigationBarStyle:animated];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    
//}

- (void)safeSetDictionary:(NSMutableDictionary *)dictionary object:(id)object forKey:(NSString const *)key
{
    if (object == nil) {
        return;
    }
    [dictionary setObject:object forKey:key];
}

#pragma mark the way who change it who restore it
//- (void)viewWillAppear:(BOOL)animated
//{
//    // change the navigation bar style
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    // restore the navigation bar style
//}

#pragma mark - associate object

- (NSMutableDictionary *)navigationBarPropertyDictionary
{
    return objc_getAssociatedObject(self, @selector(navigationBarPropertyDictionary));
}

- (void)setNavigationBarPropertyDictionary:(NSMutableDictionary *)navigationBarPropertyDictionary
{
    objc_setAssociatedObject(self, @selector(navigationBarPropertyDictionary), navigationBarPropertyDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
