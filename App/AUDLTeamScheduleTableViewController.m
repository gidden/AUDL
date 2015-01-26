//
//  AUDLTeamScheduleTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLTeamScheduleTableViewController.h"
#import "AUDLScheduleTableViewCell.h"
#import "AUDLAppDelegate.h"

@interface AUDLTeamScheduleTableViewController ()

@end

@implementation AUDLTeamScheduleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // use the xib from the main schedule page -> same layout
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // each cell is height 100 in xib, so rowHeight must be 100 too
    self.tableView.rowHeight = 100;
    
    // nav title is currently "CityName Schedule"
    self.navigationItem.title = [self.teamCity stringByAppendingString:@" Schedule"];
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
    // the first two elements are teamName and teamId
    return [self.teamSchedule count]-2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "+2" is to start at first schedule item
    // index 0 is the team's name
    // index 1 is the team's id
    NSArray *thisScheduleItem = [self.teamSchedule objectAtIndex:indexPath.row+2];
    NSString *cellIdentifier = @"Cell";
    
    AUDLScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[AUDLScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    // get an instance of the appDelegate to access global icon dictionary
    AUDLAppDelegate *appDelegate = (AUDLAppDelegate *)[[UIApplication sharedApplication] delegate];
    // get a temporary pointer for the icon dictionary
    NSDictionary *tempDict = appDelegate.icons;
    NSString *teamOneId = [NSString stringWithFormat: @"%@", self.teamId];
    NSString *teamTwoId = [NSString stringWithFormat: @"%@", [thisScheduleItem objectAtIndex:3]];
    
    // set the attributes for this schedule cell
    cell.teamOne.text = self.teamName;
    cell.teamOneIcon.image = [tempDict objectForKey:teamOneId];
    cell.teamTwo.text = [thisScheduleItem objectAtIndex:2];
    cell.teamTwoIcon.image = [tempDict objectForKey:teamTwoId];
    NSString *date = [thisScheduleItem objectAtIndex:0];
    NSString *time = [thisScheduleItem objectAtIndex:1];
    NSString *dt = [date stringByAppendingString:@" | "];
    dt = [dt stringByAppendingString:time];
    cell.dateTime.text = dt;
    
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
