//
//  AUDLRosterTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/18/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLRosterTableViewController.h"
#import "AUDLTableViewCell.h"

@interface AUDLRosterTableViewController ()

@end

@implementation AUDLRosterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // currently uses default cell; no xib needed
    
    // nav title is currently "CityName Roster"
    self.navigationItem.title = [self.teamCity stringByAppendingString:@" Roster"];

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
    // first element is team info
    return [_roster count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //
    NSArray *thisTableCell = [self.roster objectAtIndex:indexPath.row+1];
    NSString *cellIdentifier = [thisTableCell objectAtIndex:0];
    NSString *currPlayer = cellIdentifier;
    NSString *currPlayerNumber = [thisTableCell objectAtIndex:1];
    
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    NSString *displayString;
    // this is to align the player names in the roster
    if (currPlayerNumber.length == 1) {
        // 6 spaces
        displayString = [[currPlayerNumber stringByAppendingString:@"      "] stringByAppendingString:currPlayer];
    } else {
        // 4 spaces
        displayString = [[currPlayerNumber stringByAppendingString:@"    "] stringByAppendingString:currPlayer];
    }
    
    cell.textLabel.text = displayString;
    cell.cellIdentifier = cellIdentifier;
    
    // we do not want this cell to be clickable
    cell.userInteractionEnabled = NO;
    
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
