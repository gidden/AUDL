//
//  AUDLIndivTeamTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/10/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLIndivTeamTableViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLRosterTableViewController.h"
#import "AUDLTeamScheduleTableViewController.h"
#import "AUDLTeamStatsTableViewController.h"
#import "AUDLDivisionScheduleTableViewController.h"
#import "AUDLDivisionScoreTableViewController.h"



@implementation AUDLIndivTeamTableViewController

@synthesize teamId;
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        // Custom initialization
//        
//    }
//    return self;
//}
//
- (id)initWithId:(NSString *)Id
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.teamId = Id;
        NSLog(@"%@",self.teamId);
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
    self.navigationItem.title = self.teamName;
    
    //get teams
    //[self teamRequest];
    
    // Add a gesture recognizer to the table view for the cell selection
    //UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    //[self.view addGestureRecognizer:gesture];
    
  }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self teamRequest];
    
    [self setupTabView];

}
- (void)setupTabView{
    
    //gesture recognizers for moving between tab pages
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    //add view controllers to the tabbed view
    //NSString *baseIconPath = [server_url stringByAppendingString:@"/Images/iOS/"];
    
    //create array of tabs to show
    NSArray *tabTitles = @[@"Roster",@"Schedule",@"Team Stats",@"Scores"];
    NSArray *tabViews = [NSArray array];
    UITabBarItem *thisTabItem;
    
    for( NSInteger i = 0; i < [tabTitles count]; i++)
        {
            
            NSString *thisTabTitle = [tabTitles objectAtIndex:i];
            thisTabItem = [[UITabBarItem alloc] initWithTitle:thisTabTitle image:nil selectedImage:nil];
            
            //create the appropriate view controller
            UITableViewController *thisView = [self getTeamViewController:thisTabTitle];

            thisView.tabBarItem = thisTabItem;
            
            //add it to the list of view controllers
            tabViews = [tabViews arrayByAddingObject:thisView];
        }
    
    self.tabBar.translucent = NO;
    
    self.viewControllers = tabViews;
    
}


- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self selectedIndex];
    
    [self setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self selectedIndex];
    
    [self setSelectedIndex:selectedIndex - 1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [_teamMenu count];
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *cellIdentifier = [self.teamMenu objectAtIndex:indexPath.row];
//    
//    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    // Configure the cell...
//    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
//    cell.cellIdentifier = cellIdentifier;
//    
//    // add the right pointing arrow to the cell
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
//}


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


- (void)teamRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSLog(@"%@",self.teamId);
    NSString *path = [@"/Teams/" stringByAppendingString:self.teamId];
    NSString *full_url = [server_url stringByAppendingString: path];
    NSURL * url = [[NSURL alloc] initWithString:full_url];

    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                //cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:30];
    
    // Prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    // Construct array around the Data from the response
    self.data = [NSJSONSerialization
              JSONObjectWithData:urlData
              options:0
              error:&error];
    //set team name
    //NSString *teamName = [[[self.data objectAtIndex:0] objectAtIndex:0] objectAtIndex:0];
    //teamName = [teamName stringByAppendingString:[[[self.data objectAtIndex:0] objectAtIndex:0] objectAtIndex:1]];
    //self.teamName = teamName;
    
}

- (UITableViewController*)getTeamViewController:(NSString *)tabTitle
{
    
    NSLog(tabTitle);
        UITableViewController *controllerToShow;
        
        // create the view controller we want to present
        if ([tabTitle isEqualToString:@"Roster"]) {
            AUDLRosterTableViewController *roster = [[AUDLRosterTableViewController alloc] init];
            controllerToShow = roster;
            roster.roster = _data[0];
            //NSArray *tempTeam = roster.roster[0];
            roster.teamCity = self.teamInfo[1];
            
            
        } else if ([tabTitle isEqualToString:@"Schedule"]) {
            AUDLTeamScheduleTableViewController *schedule = [[AUDLTeamScheduleTableViewController alloc] init];
            controllerToShow = schedule;
            // pass the data
            schedule.teamSchedule = self.data[1];
            // set these fields
            schedule.teamName = schedule.teamSchedule[0];
            schedule.teamId = schedule.teamSchedule[1];
            schedule.teamCity = self.teamInfo[1];
            
            
        } else if ([tabTitle isEqualToString:@"Team Stats"]) {
            AUDLTeamStatsTableViewController *stats = [[AUDLTeamStatsTableViewController alloc] init];
            controllerToShow = stats;
            // pass the data
            stats.teamStats = _data[2];
            // set these fields
            NSArray *tempTeamArray = stats.teamStats[0];
            stats.teamName = tempTeamArray[1];
            stats.teamId = tempTeamArray[2];
            stats.teamCity = self.teamInfo[1];
            stats.navigationTitle = stats.teamName; //[stats.teamName stringByAppendingString:@" Statistics"];
            
        } else if ([tabTitle isEqualToString:@"Scores"]) {
            AUDLDivisionScoreTableViewController *scores = [[AUDLDivisionScoreTableViewController alloc] init];
            controllerToShow = scores;
            // pass the data
            scores.schedule = _data[3];
            // set these fields
            //scores.teamName = scores.teamSchedule[0];
            //scores.teamId = scores.teamSchedule[1];
            //scores.teamCity = self.teamInfo[1];
        }

        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        // present the new view controller
//        [self.navigationController pushViewController:controllerToShow animated:YES];

    return controllerToShow;
    
}

@end
