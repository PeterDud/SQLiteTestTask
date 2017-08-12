//
//  PDTaskTableViewCell.m
//  TestApplication
//
//  Created by Lavrin on 8/11/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import "PDTaskTableViewCell.h"
#import "DBManager.h"

@implementation PDTaskTableViewCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) handleHorizontalSwipe:(UISwipeGestureRecognizer *) gesture {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.descriptionLabel.text];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    [self.descriptionLabel setAttributedText:attributeString];
    
    // Fading animation of status label
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 0.75;
    [self.statusLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    
    // This will fade:
    self.statusLabel.text = @"Completed";

    DBManager *dbManager = [[DBManager alloc] initWithDatabaseFilename:@"tasksdb.sql"];
    
    NSString *query = [NSString stringWithFormat:@"update tasksInfo set status='completed' where taskID=%d", self.recordIDToEdit];
    [dbManager executeQuery:query];
}











@end
