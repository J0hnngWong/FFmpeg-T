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
#import "UIViewController+CustomStyle.h"

@interface ViewControllerA ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *goToBVCButton;
@property (weak, nonatomic) IBOutlet UIButton *goToCVCButton;
@property (weak, nonatomic) IBOutlet UIButton *customButton;

@end

@implementation ViewControllerA

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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.customButton.frame.size.width/2, self.customButton.frame.size.height)];
    view.backgroundColor = [UIColor grayColor];
    view.userInteractionEnabled = YES;
    [self.customButton addSubview:view];
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
- (IBAction)button:(id)sender {
    NSLog(@"-----click----------");
}

@end
