//
//  ViewControllerC.m
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/18.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import "ViewControllerC.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "UIViewController+CustomStyle.h"

@interface ViewControllerC ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *goToAVCButton;
@property (weak, nonatomic) IBOutlet UIButton *goToBVCButton;

@end

@implementation ViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pr_renderAction];
    [self showWhiteStyle];
    NSLog(@"%@ view did load", NSStringFromClass(self.class));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ view will appear", NSStringFromClass(self.class));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ view did appear", NSStringFromClass(self.class));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%@ view will disappear", NSStringFromClass(self.class));
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"%@ view did disappear", NSStringFromClass(self.class));
}

- (void)pr_renderAction
{
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.goToAVCButton addTarget:self action:@selector(goToAAction) forControlEvents:UIControlEventTouchUpInside];
    [self.goToBVCButton addTarget:self action:@selector(goToBAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backAction
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)goToAAction
{
    ViewControllerA *aVC = [[ViewControllerA alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:aVC animated:YES];
    }
}

- (void)goToBAction
{
    ViewControllerB *bVC = [[ViewControllerB alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:bVC animated:YES];
    }
}

@end
