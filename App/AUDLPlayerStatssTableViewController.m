//
//  AUDLPlayerStatssTableViewController.m
//  AUDL
//
//  Created by Evan Rypel on 4/17/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLPlayerStatsTableViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLStatsViewController.h"
#import "AUDLTop5TableViewCell.h"
#import "AUDLAppDelegate.h"

@interface AUDLPlayerStatsTableViewController ()

@end

@implementation AUDLPlayerStatsTableViewController

- (id)initWithTop5:(NSArray *)top
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.top = top;
        //self.navigationItem.title = @"League Leaders";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLTop5TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    //self.tableView.rowHeight = 100;
    self.navigationItem.title = self.stat;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.top count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"creating the stats list");
    NSArray *thisStatsItem = [self.top objectAtIndex:indexPath.row];
    //NSLog(thisStatsItem[0]);
    
    //NSLog(@"cell identifier");
    //NSString *cellIdentifier = [thisNewsItem objectAtIndex:0];
    NSString *cellIdentifier = @"Cell";
    
    //NSLog(@"creating top5 table cell");
    //NSString *cellLink = [thisNewsItem objectAtIndex:2];
    
    AUDLTop5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //AUDLScheduleTableViewCell *cell = nil;
    //NSLog(@"just checking");
    if (cell == nil) {
        cell = [[AUDLTop5TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *playerTeamId = [NSString stringWithFormat:@"%@", thisStatsItem[2]];
    AUDLAppDelegate *appDelegate = (AUDLAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *tempDict = appDelegate.icons;
    cell.imageView.image = [tempDict objectForKey:playerTeamId];
    
    //NSLog(@"Setting up top 5 table cell");
    cell.playerName.text = thisStatsItem[0];
    cell.number.text = [NSString stringWithFormat:@"%@", thisStatsItem[1]];
    //should be object at index 2
    cell.icon = nil;
    //NSLog(@"at the end");
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
