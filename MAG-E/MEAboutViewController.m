//
//  MEAboutViewController.m
//  MAG-E
//
//  Created by Abbin Varghese on 13/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MEAboutViewController.h"

@interface MEAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *buildNumber;
@end

@implementation MEAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    _buildNumber.text = [NSString stringWithFormat:@"mag.e %@",[self appVersion]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
