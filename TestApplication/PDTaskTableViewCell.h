//
//  PDTaskTableViewCell.h
//  TestApplication
//
//  Created by Lavrin on 8/11/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDTaskTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) int recordIDToEdit;

- (void) handleHorizontalSwipe:(UISwipeGestureRecognizer *) gesture;

@end
