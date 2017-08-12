//
//  PDTasksTableViewController.h
//  TestApplication
//
//  Created by Lavrin on 8/10/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoViewController.h"

@interface PDTasksTableViewController : UITableViewController <EditInfoViewControllerDelegate>

- (IBAction)addNewTask:(id)sender;

@end
