//
//  AUDLDivisionScoreTableViewController.m
//  AUDL
//
//  Created by Patrick on 1/25/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLDivisionScoreTableViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLScoreTableViewCell.h"
#import "AUDLAppDelegate.h"
#import "AUDLGameGraphViewController.h"

@interface AUDLDivisionScoreTableViewController ()

@end

@implementation AUDLDivisionScoreTableViewController

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLScoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = 100;
    self.navigationItem.title = [_division stringByAppendingString:@" Division" ];
    
    // Add a gesture recognizer to the table view for the cell selection
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    [self.view addGestureRecognizer:gesture];
    
    
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
    
    //get the game info for this index
    NSArray *thisGameItem = [self.schedule objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = @"Cell";
    
    AUDLScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //AUDLScheduleTableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[AUDLScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    // get an instance of the appDelegate to access global icon dictionary
    AUDLAppDelegate *appDelegate = (AUDLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // get a temporary pointer for the icon dictionary
    NSDictionary *tempDict = appDelegate.icons;
    
    NSString *teamOneId = [NSString stringWithFormat: @"%@", [thisGameItem objectAtIndex:1]];
    NSString *teamTwoId = [NSString stringWithFormat: @"%@", [thisGameItem objectAtIndex:3]];
    
    
    //populate the cell info
    cell.teamOne.text = [thisGameItem objectAtIndex:0];
    cell.teamOneIcon.image = [tempDict objectForKey:teamOneId];
    cell.teamTwo.text = [thisGameItem objectAtIndex:2];
    cell.teamTwoIcon.image = [tempDict objectForKey:teamTwoId];
    cell.date.text = [thisGameItem objectAtIndex:4];
    //cell.status.text = [thisGameItem objectAtIndex:5];


    cell.teamOneScore.text = [NSString stringWithFormat:@"%@",[thisGameItem objectAtIndex:6]];
    cell.teamTwoScore.text = [NSString stringWithFormat:@"%@",[thisGameItem objectAtIndex:7]];
    teamOneId = [NSString stringWithFormat:[teamOneId stringByAppendingString:@"/"]];
    cell.gameID = [NSString stringWithString:[teamOneId stringByAppendingString:cell.date.text]];


    NSString *statusVal = [NSString stringWithFormat:@"%@",[thisGameItem objectAtIndex:8]];
    
    if([statusVal isEqualToString:@"0"])
    {
        cell.status.text = [thisGameItem objectAtIndex:5];
    }
    else if ( [statusVal isEqualToString:@"1"])
    {
        cell.status.text = @"Ongoing";
    }
    else if ( [statusVal isEqualToString:@"2"])
    {
        cell.status.text = @"Final";
    }
    else if ( [statusVal isEqualToString:@"3"])
    {
        cell.status.text = @"Final";
    }
    else
    {
        cell.status.text = @"Default Case";
    }
    
    return cell;
}


- (void)didSelect:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint tapLocation = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
        UITableViewCell* tappedCell = [self.tableView cellForRowAtIndexPath:tappedIndexPath];
        
        
        // pointer to the cell that was selected
        AUDLScoreTableViewCell* selectedCell = (AUDLScoreTableViewCell*)tappedCell;
        
        if (![selectedCell.gameID isEqualToString: @""]) {
            
            
            // opens the selected cell's url in Safari
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectedCell.link]];
            
            
            // create the view controller we want to present
            AUDLGameGraphViewController *gameGraph = [[AUDLGameGraphViewController alloc] initWithGameID: selectedCell.gameID];
            
            //AUDLIndivTeamTableViewController *teamSelection = [[AUDLIndivTeamTableViewController alloc] init];
            //teamSelection.teamName = selectedCell.teamName;
            //teamSelection.teamId = selectedCell.teamId;
            
            // override the back button in the new controller from saying "Schedule"
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            //NSLog(@"%@",selectedCell.gameID);
            // present the new view controller
            [self.navigationController pushViewController:gameGraph animated:YES];
            
        }
        
    }
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
