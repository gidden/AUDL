//
//  AUDLDivisionTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/6/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLDivisionTableViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLScheduleTableViewCell.h"
#import "AUDLAppDelegate.h"

@interface AUDLDivisionTableViewController ()

@end

@implementation AUDLDivisionTableViewController

- (id)initWithSchedule:(NSArray *)schedule
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.schedule = schedule;
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
    //self.navigationItem.hidesBackButton =YES;

    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = 100;
    self.navigationItem.title = [_division stringByAppendingString:@" Division" ];

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
    return [self.schedule count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "+1" is to start at first story, not the header
    NSArray *thisNewsItem = [self.schedule objectAtIndex:indexPath.row];
    
    //NSString *cellIdentifier = [thisNewsItem objectAtIndex:0];
    NSString *cellIdentifier = @"Cell";

    //NSString *cellLink = [thisNewsItem objectAtIndex:2];
    AUDLScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //AUDLScheduleTableViewCell *cell = nil;

    if (cell == nil) {
        cell = [[AUDLScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    // get an instance of the appDelegate to access global icon dictionary
    AUDLAppDelegate *appDelegate = (AUDLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // get a temporary pointer for the icon dictionary
    NSDictionary *tempDict = appDelegate.icons;
    
    NSString *teamOneId = [NSString stringWithFormat: @"%@", [thisNewsItem objectAtIndex:1]];
    NSString *teamTwoId = [NSString stringWithFormat: @"%@", [thisNewsItem objectAtIndex:3]];

    
    //cell.imageView.image = [tempDict objectForKey:@"5182111044599808"];
    //cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    //[cell setLink:cellLink];
    cell.teamOne.text = [thisNewsItem objectAtIndex:0];
    cell.teamOneIcon.image = [tempDict objectForKey:teamOneId];
    cell.teamTwo.text = [thisNewsItem objectAtIndex:2];
    cell.teamTwoIcon.image = [tempDict objectForKey:teamTwoId];
    cell.date.text = [thisNewsItem objectAtIndex:4];
    cell.time.text = [thisNewsItem objectAtIndex:5];
    cell.teamOneScore.text = [NSString stringWithFormat:@"%@",[thisNewsItem objectAtIndex:6]];
    cell.teamTwoScore.text = [NSString stringWithFormat:@"%@",[thisNewsItem objectAtIndex:7]];

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
