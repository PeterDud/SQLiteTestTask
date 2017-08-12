//
//  PDArticleViewController.m
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import "PDArticleViewController.h"

@interface PDArticleViewController ()

@end

@implementation PDArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.articleTitle.text = self.articleToShow.title;
    self.articleDesc.text  = self.articleToShow.desc;
    self.articleURL.text   = self.articleToShow.url;
    self.articleDate.text  = self.articleToShow.publishedAt;
    self.articleImage.image = self.articleToShow.articleImageView;
    //    [self.view setNeedsDisplay];

    
}

- (void) viewWillAppear:(BOOL)animated {
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
