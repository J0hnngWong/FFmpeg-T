//
//  RootViewController.m
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/18.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import "RootViewController.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "ViewControllerC.h"

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIButton *AButton;
@property (weak, nonatomic) IBOutlet UIButton *BButton;
@property (weak, nonatomic) IBOutlet UIButton *CButton;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pr_renderAction];
}

- (void)pr_renderAction
{
    [self.AButton addTarget:self action:@selector(AAction) forControlEvents:UIControlEventTouchUpInside];
    [self.BButton addTarget:self action:@selector(BAction) forControlEvents:UIControlEventTouchUpInside];
    [self.CButton addTarget:self action:@selector(CAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)AAction
{
    ViewControllerA *aVC = [[ViewControllerA alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:aVC animated:YES];
    }
}

- (void)BAction
{
    ViewControllerB *bVC = [[ViewControllerB alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:bVC animated:YES];
    }
}

- (void)CAction
{
    ViewControllerC *cVC = [[ViewControllerC alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:cVC animated:YES];
    }
}

@end
