//
//  PDTasksTableViewController.m
//  TestApplication
//
//  Created by Lavrin on 8/10/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import "PDTasksTableViewController.h"
#import "DBManager.h"
#import "PDTaskTableViewCell.h"

@interface PDTasksTableViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrTasksInfo;
@property (nonatomic) int recordIDToEdit;

-(void)loadData;

@end

@implementation PDTasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Tasks";
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"tasksdb.sql"];
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SQLite

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from tasksInfo";
    
    // Get the results.
    if (self.arrTasksInfo != nil) {
        self.arrTasksInfo = nil;
    }
    self.arrTasksInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tableView reloadData];
}


#pragma mark - Actions

- (IBAction)addNewTask:(id)sender {
    self.recordIDToEdit = -1;
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrTasksInfo.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    PDTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSInteger indexOfTitle = [self.dbManager.arrColumnNames indexOfObject:@"title"];
    NSInteger indexOfDesc  = [self.dbManager.arrColumnNames indexOfObject:@"description"];
    NSInteger indexOfDate  = [self.dbManager.arrColumnNames indexOfObject:@"date"];
    NSInteger indexOfStatus  = [self.dbManager.arrColumnNames indexOfObject:@"status"];

    // Set the loaded data to the appropriate cell labels.
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfTitle]];
    
    NSString *description = [NSString stringWithFormat:@"%@", [[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDesc]];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", [[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDate]];
    NSString *status = [NSString stringWithFormat:@"%@", [[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfStatus]];
    cell.statusLabel.text = status;
    
    if ([status isEqualToString:@"completed"]) {
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:description];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        [cell.descriptionLabel setAttributedText:attributeString];
    } else {
        cell.descriptionLabel.text = description;
    }
    
    cell.recordIDToEdit = [[[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    // Gesture Recognizer
    
    UISwipeGestureRecognizer *horizontalSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:cell action:@selector(handleHorizontalSwipe:)];
    horizontalSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    horizontalSwipe.delegate = self;

    [cell.contentView addGestureRecognizer:horizontalSwipe];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.recordIDToEdit = [[[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        int recordIDToDelete = [[[self.arrTasksInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from tasksInfo where taskID=%d", recordIDToDelete];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // Reload the table view.
        [self loadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditInfoViewController *editInfoViewController = [segue destinationViewController];
    editInfoViewController.delegate = self;
    editInfoViewController.recordIDToEdit = self.recordIDToEdit;

}


#pragma mark - EditInfoViewControllerDelegate 

-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}












@end

