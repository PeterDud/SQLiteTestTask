//
//  EditInfoViewController.h
//  TestApplication
//
//  Created by Lavrin on 8/10/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end


@interface EditInfoViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtTaskTitle;

@property (weak, nonatomic) IBOutlet UITextView *txtTaskDesc;
@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegate;
@property (nonatomic) int recordIDToEdit;


- (IBAction)saveInfo:(id)sender;


@end
