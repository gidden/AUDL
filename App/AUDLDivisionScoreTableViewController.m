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
    
    //Trick section headers into being anchored to cell views
    CGFloat dummyViewHeight = 40;
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, dummyViewHeight)];
    self.tableView.tableHeaderView = dummyView;
    self.tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0);
    
    
    [self sortScores];
}

-(void)sortScores
{
    NSInteger num_of_games = [self.schedule count];
    NSLog(@"%zd",num_of_games);
    NSMutableDictionary *sortedScores = [[NSMutableDictionary alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"'MM'/'dd'/'yy'"];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    for( NSInteger i = 0; i < num_of_games; i++)
    {
        NSArray *game = [self.schedule objectAtIndex:i];
        NSString *gameDate = [game objectAtIndex:4];
        NSDate *dateKey = [df dateFromString:gameDate];
        
        if([sortedScores.allKeys containsObject:dateKey])
        {
            NSArray *game_list = [sortedScores objectForKey:dateKey];
            game_list = [game_list arrayByAddingObject:game];
            [sortedScores setObject:game_list forKey:dateKey];
        }
        else
        {
            NSArray *game_list = [NSArray arrayWithObject:game];
            [sortedScores setObject:game_list forKey:dateKey];
        }
        
    }
    
    //get the dictionary keys (dates)
    NSArray *keys = [NSArray arrayWithArray:sortedScores.allKeys];
    //sort these dates chronologically
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    keys = [[keys reverseObjectEnumerator] allObjects];
    
    //set the object's attributes
    self.dateKeys = keys;
    self.game_dict = [[NSDictionary alloc] initWithDictionary:sortedScores];

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
    return [self.game_dict.allKeys count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *thisDate = [self.dateKeys objectAtIndex:section];
    // all of these objects have the same date string, use the first one to set the title
    return (NSString*)[[[self.game_dict objectForKey:thisDate] objectAtIndex:0] objectAtIndex:4];
}


-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //setup view for the section header
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
    headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
    
    
    //create a background image for the header
    UIImage *bg = [UIImage imageNamed:@"Blue_Bar"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bg];
    imageView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height);
    imageView.clipsToBounds = YES;

    //create title for the section header
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 10, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    NSDate *thisDate = [self.dateKeys objectAtIndex:section];
    // all of these objects have the same date string, use the first one
    NSString *headerTitle = [[[self.game_dict objectForKey:thisDate] objectAtIndex:0] objectAtIndex:4];
    //remove date dashes and replace with .'s
    headerLabel.text = [headerTitle stringByReplacingOccurrencesOfString:@"/" withString:@"."];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    //add these views to the header view
    [headerView addSubview:headerLabel];
    [headerView addSubview:imageView];
    [headerView sendSubviewToBack:imageView];
    
    return headerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    NSArray *section_data = [self.game_dict objectForKey:[self.dateKeys objectAtIndex:section]];
    return  [section_data count];
 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the game info for this index
    NSArray *section_data = [self.game_dict objectForKey:[self.dateKeys objectAtIndex:indexPath.section]];

    NSArray *thisGameItem = [section_data objectAtIndex:indexPath.row];
    
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

    cell.teamOneScore.textColor = [UIColor colorWithRed:(121/255.0) green:(123/255.0) blue:(125/255.0) alpha:1];
    cell.teamTwoScore.textColor = [UIColor colorWithRed:(121/255.0) green:(123/255.0) blue:(125/255.0) alpha:1];
    cell.teamOneScore.text = [NSString stringWithFormat:@"%@",[thisGameItem objectAtIndex:6]];
    cell.teamTwoScore.text = [NSString stringWithFormat:@"%@",[thisGameItem objectAtIndex:7]];
    teamOneId = [NSString stringWithFormat:[teamOneId stringByAppendingString:@"/"]];
    cell.gameID = [NSString stringWithString:[teamOneId stringByAppendingString:cell.date.text]];

    cell.status.text =  [thisGameItem objectAtIndex:5];

    NSString *statusVal = [NSString stringWithFormat:@"%@",[thisGameItem objectAtIndex:8]];

    [self setCellStatus:cell withStatusValue:statusVal];
    

    return cell;
}

-(AUDLScoreTableViewCell*)setCellStatus:(AUDLScoreTableViewCell*)cell withStatusValue:(NSString*)statusValue
{
    
    if([statusValue isEqualToString:@"0"])
    {
        return cell; // do nothing
    }
    else if ( [statusValue isEqualToString:@"1"])
    {
        cell.status.text = @"Ongoing";
    }
    else if ( [statusValue isEqualToString:@"2"])
    {
        cell.status.text = @"Final";
    }
    else if ( [statusValue isEqualToString:@"3"])
    {
        cell.status.text = @"Final";
    }
    else
    {
        cell.status.text = @"Default Case";
    }

    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    //if this score is final, then adjust the font of the higher score
    //(if tied, do nothing)
    if( [cell.status.text isEqualToString:@"Final"])
    {
        NSNumber *scoreOne = [nf numberFromString:cell.teamOneScore.text];
        NSNumber *scoreTwo = [nf numberFromString:cell.teamTwoScore.text];
        NSLog(@"%@",scoreOne);
        NSLog(@"%@",scoreTwo);
        if ( scoreOne > scoreTwo)
        {
            cell.teamOneScore.textColor = [UIColor colorWithRed:0 green:(45/255.0) blue:(86/255.0) alpha:1];
            NSLog(@"Text One Changed");
        }
        else if ( scoreTwo > scoreOne)
        {
            cell.teamTwoScore.textColor = [UIColor colorWithRed:0 green:(45/255.0) blue:(86/255.0) alpha:1];
            NSLog(@"Text Two Changed");
        }


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
