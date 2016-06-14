//
//  MEMenuViewController.m
//  MAG-E
//
//  Created by Abbin Varghese on 13/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MEMenuViewController.h"
#import "MEAboutViewController.h"
#import "MEFeedbackViewController.h"

typedef NS_ENUM(NSInteger, cellIndex) {
    Channels,
    AppStoreRating,
    FeedBack,
    About
};

@interface MEMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation MEMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _profilePhotoView.layer.cornerRadius = _profilePhotoView.frame.size.height/2;
    _profilePhotoView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MEMenuViewControllerCell"];
    switch (indexPath.row) {
        case Channels:
            cell.accessoryView.hidden = YES;
            cell.textLabel.text = @"Channels";
            cell.imageView.image = [UIImage imageNamed:@"Channel"];
            break;
        case AppStoreRating:
            cell.accessoryView.hidden = YES;
            cell.textLabel.text = @"Rate us on the AppStore";
            cell.imageView.image = [UIImage imageNamed:@"AppStore"];
            break;
        case FeedBack:
            cell.accessoryView.hidden = YES;
            cell.textLabel.text = @"Send us a feedback";
            cell.imageView.image = [UIImage imageNamed:@"FeedBack"];
            break;
        case About:
            cell.accessoryView.hidden = YES;
            cell.textLabel.text = @"About us";
            cell.imageView.image = [UIImage imageNamed:@"About"];
            break;

            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case Channels:
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case AppStoreRating:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/app/id284882215"]];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case FeedBack:{
            MEFeedbackViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"MEFeedbackViewController"];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self.navigationController pushViewController:newView animated:YES];
        }
            break;
        case About:{
            MEAboutViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"MEAboutViewController"];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self.navigationController pushViewController:newView animated:YES];
        }
            break;
        default:
            break;
    }
    
}


@end
