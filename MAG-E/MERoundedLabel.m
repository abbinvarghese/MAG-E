//
//  MERoundedLabel.m
//  MAG-E
//
//  Created by Abbin Varghese on 09/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MERoundedLabel.h"

@implementation MERoundedLabel

-(void)layoutSubviews{
    self.frame = CGRectMake(self.frame.origin.x-3, self.frame.origin.y-1, self.frame.size.width+6, self.frame.size.height+2);
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
}

@end
