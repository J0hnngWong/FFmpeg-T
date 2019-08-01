//
//  UIViewController+NavigationBarStyleKeeper.m
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/24.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import "UIViewController+NavigationBarStyleKeeper.h"
#import <objc/runtime.h>

//基础属性和导航栏元素
NSString const * navigationBarBarStyleKey = @"navigationBarBarStyle"; //1
NSString const * navigationBarDelegateKey = @"navigationBarDelegate"; //2
NSString const * navigationBarTranslucentKey = @"navigationBarTranslucent"; //3
NSString const * navigationBarTopItemKey = @"navigationBarTopItem"; //4
NSString const * navigationBarBackItemKey = @"navigationBarBackItem"; //5
NSString const * navigationBarItemsKey = @"navigationBarItems"; //6
NSString const * navigationBarPrefersLargeTitleKey = @"navigationBarPrefersLargeTitle"; //7
NSString const * navigationBarTintColorKey = @"navigationBarTintColor"; //8
NSString const * navigationBarBarTintColorKey = @"navigationBarBarTintColor"; //9

//在UIBarPositionAny状态下的背景图片
NSString const * navigationBarBackgroundImageForDefaultBarMetricsKey = @"navigationBarBackgroundImageForDefaultBarMetrics"; //10
NSString const * navigationBarBackgroundImageForCompactBarMetricsKey = @"navigationBarBackgroundImageForCompactBarMetrics"; //10
NSString const * navigationBarBackgroundImageForDefaultPromptBarMetricsKey = @"navigationBarBackgroundImageForDefaultPromptBarMetrics"; //10
NSString const * navigationBarBackgroundImageForCompactPromptBarMetricsKey = @"navigationBarBackgroundImageForCompactPromptBarMetrics"; //10

//阴影图和属性文字
NSString const * navigationBarShadowImageKey = @"navigationBarShadowImage"; //11
NSString const * navigationBarTitleTextAttributeKey = @"navigationBarTitleTextAttribute"; //12
NSString const * navigationBarLargeTitleTextAttributesKey = @"navigationBarLargeTitleTextAttributes"; //13

//标题垂直位置调整偏移
NSString const * navigationBarTitleVerticalPositionAdjustmentForDefaultBarMetricsKey = @"navigationBarTitleVerticalPositionAdjustmentForDefaultBarMetrics"; //14
NSString const * navigationBarTitleVerticalPositionAdjustmentForCompactBarMetricsKey = @"navigationBarTitleVerticalPositionAdjustmentForCompactBarMetrics"; //14
NSString const * navigationBarTitleVerticalPositionAdjustmentForDefaultPromptBarMetricsKey = @"navigationBarTitleVerticalPositionAdjustmentForDefaultPromptBarMetrics"; //14
NSString const * navigationBarTitleVerticalPositionAdjustmentForCompactPromptBarMetricsKey = @"navigationBarTitleVerticalPositionAdjustmentForCompactPromptBarMetrics"; //14

//返回指示器相关
NSString const * navigationBarBackIndicatorImageKey = @"navigationBarBackIndicatorImage"; //15
NSString const * navigationBarBackIndicatorTransitionMaskImageKey = @"navigationBarBackIndicatorTransitionMaskImage"; //16

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
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@(self.navigationController.navigationBar.barStyle) forKey:navigationBarBarStyleKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@(self.navigationController.navigationBar.translucent) forKey:navigationBarTranslucentKey];
//        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.topItem copy] forKey:navigationBarTopItemKey];
//        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.backItem copy] forKey:navigationBarBackItemKey];
//        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.items copy] forKey:navigationBarItemsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@(self.navigationController.navigationBar.prefersLargeTitles) forKey:navigationBarPrefersLargeTitleKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.tintColor copy] forKey:navigationBarTintColorKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.barTintColor copy] forKey:navigationBarBarTintColorKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] copy] forKey:navigationBarBackgroundImageForDefaultBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsCompact] copy] forKey:navigationBarBackgroundImageForCompactBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefaultPrompt] copy] forKey:navigationBarBackgroundImageForDefaultPromptBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsCompactPrompt] copy] forKey:navigationBarBackgroundImageForCompactPromptBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.shadowImage copy] forKey:navigationBarShadowImageKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.titleTextAttributes copy] forKey:navigationBarTitleTextAttributeKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.largeTitleTextAttributes copy] forKey:navigationBarLargeTitleTextAttributesKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@([self.navigationController.navigationBar titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault]) forKey:navigationBarTitleVerticalPositionAdjustmentForDefaultBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@([self.navigationController.navigationBar titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsCompact]) forKey:navigationBarTitleVerticalPositionAdjustmentForCompactBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@([self.navigationController.navigationBar titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefaultPrompt]) forKey:navigationBarTitleVerticalPositionAdjustmentForDefaultPromptBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:@([self.navigationController.navigationBar titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsCompactPrompt]) forKey:navigationBarTitleVerticalPositionAdjustmentForCompactPromptBarMetricsKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.backIndicatorImage copy] forKey:navigationBarBackIndicatorImageKey];
        [self safeSetDictionary:self.navigationBarPropertyDictionary object:[self.navigationController.navigationBar.backIndicatorTransitionMaskImage copy] forKey:navigationBarBackIndicatorTransitionMaskImageKey];
    }
    [self viewDidAppearSaveNavigationBarStyle:animated];
}

- (void)viewWillAppearRestoreNavigationBarStyle:(BOOL)animated
{
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // restore navigation bar style
    if (self.navigationBarPropertyDictionary && self.navigationController && self.navigationController.navigationBar) {
        // only pop to this controller will pass this condition check
        [self.navigationController.navigationBar setBarStyle:[[self.navigationBarPropertyDictionary objectForKey:navigationBarBarStyleKey] integerValue]];
        [self.navigationController.navigationBar setTranslucent:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTranslucentKey] boolValue]];
//        [self.navigationController.navigationBar setItems:[self.navigationBarPropertyDictionary objectForKey:navigationBarItemsKey]];
        [self.navigationController.navigationBar setPrefersLargeTitles:[[self.navigationBarPropertyDictionary objectForKey:navigationBarPrefersLargeTitleKey] boolValue]];
        [self.navigationController.navigationBar setTintColor:[self.navigationBarPropertyDictionary objectForKey:navigationBarTintColorKey]];
        [self.navigationController.navigationBar setBarTintColor:[self.navigationBarPropertyDictionary objectForKey:navigationBarBarTintColorKey]];
        [self.navigationController.navigationBar setBackgroundImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackgroundImageForDefaultBarMetricsKey] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackgroundImageForCompactBarMetricsKey] forBarMetrics:UIBarMetricsCompact];
        [self.navigationController.navigationBar setBackgroundImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackgroundImageForDefaultPromptBarMetricsKey] forBarMetrics:UIBarMetricsDefaultPrompt];
        [self.navigationController.navigationBar setBackgroundImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackgroundImageForCompactPromptBarMetricsKey] forBarMetrics:UIBarMetricsCompactPrompt];
        [self.navigationController.navigationBar setShadowImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarShadowImageKey]];
        [self.navigationController.navigationBar setTitleTextAttributes:[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleTextAttributeKey]];
        [self.navigationController.navigationBar setLargeTitleTextAttributes:[self.navigationBarPropertyDictionary objectForKey:navigationBarLargeTitleTextAttributesKey]];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForDefaultBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForCompactBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsCompact];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForDefaultPromptBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsDefaultPrompt];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForCompactPromptBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsCompactPrompt];
        [self.navigationController.navigationBar setShadowImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarShadowImageKey]];
        [self.navigationController.navigationBar setTitleTextAttributes:[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleTextAttributeKey]];
        [self.navigationController.navigationBar setLargeTitleTextAttributes:[self.navigationBarPropertyDictionary objectForKey:navigationBarLargeTitleTextAttributesKey]];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForDefaultBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForCompactBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsCompact];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForDefaultPromptBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsDefaultPrompt];
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:[[self.navigationBarPropertyDictionary objectForKey:navigationBarTitleVerticalPositionAdjustmentForCompactPromptBarMetricsKey] doubleValue] forBarMetrics:UIBarMetricsCompactPrompt];
        [self.navigationController.navigationBar setBackIndicatorImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackIndicatorImageKey]];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[self.navigationBarPropertyDictionary objectForKey:navigationBarBackIndicatorTransitionMaskImageKey]];
    }
    [self viewWillAppearRestoreNavigationBarStyle:animated];
}

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
