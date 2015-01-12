//
//  AUDLDivStandingsTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/10/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLDivStandingsTableViewController.h"
#import "AUDLStandingsTableViewCell.h"
#import "AUDLAppDelegate.h"

@interface AUDLDivStandingsTableViewController ()

@end

@implementation AUDLDivStandingsTableViewController

- (id)initWithSchedule:(NSArray *)standings
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.standings = standings;
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLStandingsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = 80;
    self.navigationItem.title = _division;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.standings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *thisTeam = [self.standings objectAtIndex:indexPath.row];

    NSString *cellIdentifier = @"Cell";
    
    AUDLStandingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[AUDLStandingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Grab the icons dictionary
    AUDLAppDelegate *appDelegate = (AUDLAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSDictionary *logos = appDelegate.icons;
    
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    NSString *teamID = [NSString stringWithFormat:@"%@", [thisTeam objectAtIndex:1]];
    
    cell.teamIcon.image = [logos objectForKey:teamID];
    
    cell.teamName.text = [thisTeam objectAtIndex:0];
    NSString *wins = [ NSString stringWithFormat:@"%@",[thisTeam objectAtIndex:2]];
    NSString *losses = [ NSString stringWithFormat:@"%@",[thisTeam objectAtIndex:3]];
    
    NSString *rec = [wins stringByAppendingString:@" - "];
    cell.record.text = [rec stringByAppendingString:losses];
    cell.pDiff.text = [NSString stringWithFormat:@"%@", [thisTeam objectAtIndex:4]];

    //Grab this cell's index
    //NSString *placement = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    
    
    

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
