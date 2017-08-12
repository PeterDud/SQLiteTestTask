//
//  PDNewsTableViewController.m
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import "PDNewsTableViewController.h"
#import "PDArticle.h"
#import "PDServerManager.h"
#import "PDArticleTableViewCell.h"

@interface PDNewsTableViewController ()

@property (strong, nonatomic) NSMutableArray *articlesArray;

@property (strong, nonatomic) PDArticle *articleToShow;

@end

@implementation PDNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.articlesArray = [NSMutableArray array];
    [self getArticlesFromServer];
    self.title = @"News";
}



#pragma mark - API

- (void) getArticlesFromServer {
    
    [[PDServerManager sharedManager]
    getNewsOnSuccess:^(NSArray *articles) {
       
        [self.articlesArray addObjectsFromArray:articles];
        
        NSMutableArray* newPaths = [NSMutableArray array];
        for (int i = 0; i < [self.articlesArray count]; i++) {
            [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"%@", [error localizedDescription]);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.articlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PDArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    PDArticle *article = [self.articlesArray objectAtIndex: indexPath.row];
    
    cell.titleLabel.text = article.title;
    
    __weak PDArticleTableViewCell *weakCell = cell;
    __weak PDArticle *weakArticle = article;
    NSURLSessionDownloadTask *downloadPhotoTask =
    [[NSURLSession sharedSession]
     downloadTaskWithURL:article.imageURL
     completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
         
         UIImage *image = [UIImage imageWithData:
                           [NSData dataWithContentsOfURL:location]];
         
         weakCell.articleImageView.image = image;
         weakArticle.articleImageView = image;
         
         [weakCell layoutSubviews];
     }];
    
    [downloadPhotoTask resume];

    return cell;
}

#pragma mark - UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.articleToShow = [self.articlesArray objectAtIndex: indexPath.row];
    [self performSegueWithIdentifier:@"idSegueArticleInfo" sender:self];
}


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PDArticleViewController *articleViewController = [segue destinationViewController];

    articleViewController.articleToShow = self.articleToShow;
}












@end
