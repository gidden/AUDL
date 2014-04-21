//
//  AUDLTeamStatsTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLTeamStatsTableViewController.h"
#import "AUDLTeamStatsTableViewCell.h"

@interface AUDLTeamStatsTableViewController ()

@end

@implementation AUDLTeamStatsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // use the xib created for team stats table cells
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLTeamStatsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // each cell is height 150 in xib, so rowHeight must be 150 too
    self.tableView.rowHeight = 150;
    
    // nav title is currently "TeamName Statistics"
    self.navigationItem.title = self.navigationTitle;

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
    // the first element is an info element on the current team
    return [self.teamStats count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "+1" is to start at first schedule item
    // index 0 is the current team's info
    NSArray *thisStatItem = [self.teamStats objectAtIndex:indexPath.row+1];
    NSString *cellIdentifier = @"Cell";
    //NSLog(@"%@", self.teamStats[1]);
    
    AUDLTeamStatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[AUDLTeamStatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    //NSString * tempString = [NSString sWithFormat:[thisStatItem objectAtIndex:0]];
    //NSLog(tempString);
    // set the attributes for this schedule cell
    NSString *statString = [NSString stringWithFormat:@"%@", [thisStatItem objectAtIndex:0]];
    statString = [statString capitalizedString];
    if ([statString isEqualToString:@"Plusminuscount"]) {
        statString = @"+/-";
    }
    
    statString = [statString stringByAppendingString:@":"];
    //cell.stat.text = [NSString stringWithFormat:@"%@", [thisStatItem objectAtIndex:0]];
    cell.stat.text = statString;
    
    NSArray *topPlayersForThisStat = [thisStatItem objectAtIndex:1];
    NSArray *player1 = [topPlayersForThisStat objectAtIndex:0];
    NSArray *player2 = [topPlayersForThisStat objectAtIndex:1];
    NSArray *player3 = [topPlayersForThisStat objectAtIndex:2];
    NSArray *player4 = [topPlayersForThisStat objectAtIndex:3];
    NSArray *player5 = [topPlayersForThisStat objectAtIndex:4];
    
    cell.player1.text = [player1 objectAtIndex:0];
    cell.player1No.text = [NSString stringWithFormat:@"%@", [player1 objectAtIndex:1]];
    cell.player2.text = [player2 objectAtIndex:0];
    cell.player2No.text = [NSString stringWithFormat:@"%@", [player2 objectAtIndex:1]];
    cell.player3.text = [player3 objectAtIndex:0];
    cell.player3No.text = [NSString stringWithFormat:@"%@", [player3 objectAtIndex:1]];
    cell.player4.text = [player4 objectAtIndex:0];
    cell.player4No.text = [NSString stringWithFormat:@"%@", [player4 objectAtIndex:1]];
    cell.player5.text = [player5 objectAtIndex:0];
    cell.player5No.text = [NSString stringWithFormat:@"%@", [player5 objectAtIndex:1]];
    
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
