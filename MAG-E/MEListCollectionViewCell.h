//
//  MEListCollectionViewCell.h
//  MAG-E
//
//  Created by Abbin Varghese on 09/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Articles.h"
#import "MERoundedImageView.h"
#import "MERoundedLabel.h"

@interface MEListCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) Articles *articleObject;

@property (weak, nonatomic) IBOutlet MERoundedImageView *authorImageView;
@property (weak, nonatomic) IBOutlet MERoundedLabel *authorLabel;
@property (weak, nonatomic) IBOutlet MERoundedLabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UITextView *headingTextView;
@property (weak, nonatomic) IBOutlet MERoundedLabel *websiteLabel;

@end
