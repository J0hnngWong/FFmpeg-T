//
//  ViewControllerA.m
//  NavigationBarStyleKeeper
//
//  Created by 王嘉宁 on 2019/7/18.
//  Copyright © 2019 Johnny. All rights reserved.
//

#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "ViewControllerC.h"

@interface ViewControllerA ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *goToBVCButton;
@property (weak, nonatomic) IBOutlet UIButton *goToCVCButton;

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pr_renderAction];
}

- (void)pr_renderAction
{
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.goToBVCButton addTarget:self action:@selector(goToBAction) forControlEvents:UIControlEventTouchUpInside];
    [self.goToCVCButton addTarget:self action:@selector(goToCAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backAction
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)goToBAction
{
    ViewControllerB *bVC = [[ViewControllerB alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:bVC animated:YES];
    }
}

- (void)goToCAction
{
    ViewControllerC *cVC = [[ViewControllerC alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:cVC animated:YES];
    }
}

@end
