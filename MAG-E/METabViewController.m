//
//  METabViewController.m
//  MAG-E
//
//  Created by Abbin Varghese on 09/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "METabViewController.h"

@interface METabViewController ()

@property (strong, nonatomic) IBOutlet UIView *tabView;

@end

@implementation METabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabView.frame = CGRectMake(0.0,
                                    self.view.frame.size.height - 44,
                                    [UIScreen mainScreen].bounds.size.width,
                                    44);
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, self.tabView.frame.size.width, 0.3f);
    topBorder.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    [self.tabView.layer addSublayer:topBorder];
    [self.view addSubview:self.tabView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)settings:(UIButton *)sender {
    [self setSelectedIndex:2];
    
}
- (IBAction)saved:(UIButton *)sender {
    [self setSelectedIndex:1];
    
}
- (IBAction)home:(UIButton *)sender {
    [self setSelectedIndex:0];
    
}

@end
