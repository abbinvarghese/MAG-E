//
//  MEFeedbackViewController.m
//  MAG-E
//
//  Created by Abbin Varghese on 13/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MEFeedbackViewController.h"

@interface MEFeedbackViewController ()

@end

@implementation MEFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
