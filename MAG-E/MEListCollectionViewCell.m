//
//  MEListCollectionViewCell.m
//  MAG-E
//
//  Created by Abbin Varghese on 09/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MEListCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MEListCollectionViewCell

-(void)setArticleObject:(Articles *)articleObject{
    _authorLabel.text = articleObject.articleAuthor;
    
    NSTimeInterval theTimeInterval = [articleObject.articleTimestamp doubleValue];
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    // Create the NSDates
    NSDate *date2 = [[NSDate alloc] init];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:theTimeInterval];
    // Get conversion to months, days, hours, minutes
    NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth;
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    if ([breakdownInfo month]>0) {
        _timeLabel.text = [NSString stringWithFormat:@"%ldm",(long)[breakdownInfo month]];
    }
    else if ([breakdownInfo day]>0){
        _timeLabel.text = [NSString stringWithFormat:@"%ldd",(long)[breakdownInfo day]];
    }
    else if ([breakdownInfo hour]>0){
        _timeLabel.text = [NSString stringWithFormat:@"%ldhr",(long)[breakdownInfo hour]];
    }
    else{
        _timeLabel.text = [NSString stringWithFormat:@"%ldmin",(long)[breakdownInfo minute]];
    }
    _headingTextView.text = articleObject.articleHeading;

    _headingTextView.font = [UIFont fontWithName:@".SFUIDisplay-Light" size:self.frame.size.height/16];
    
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:articleObject.articleImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [_authorImageView sd_setImageWithURL:[NSURL URLWithString:articleObject.articleAuthorPhotoUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _websiteLabel.text = articleObject.articleWebsite;
}
- (IBAction)saveArticle:(UIButton *)sender {
}
- (IBAction)share:(UIButton *)sender {
}
- (IBAction)flagArticle:(UIButton *)sender {
}

@end
