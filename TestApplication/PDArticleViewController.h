//
//  PDArticleViewController.h
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDArticle.h"

@interface PDArticleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleDesc;
@property (weak, nonatomic) IBOutlet UILabel *articleURL;
@property (weak, nonatomic) IBOutlet UILabel *articleDate;


@property (strong, nonatomic) PDArticle* articleToShow;

@end
