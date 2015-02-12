//
//  AUDLTeamsTableViewController.m
//  App
//
//  Created by Ryan Zoellner on 3/19/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLTeamsTableViewController.h"
#import "SWRevealViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLTeamTableViewCell.h"
#import "AUDLIndivTeamTabViewController.h"
#import "AUDLAppDelegate.h"

@interface AUDLTeamsTableViewController ()

//@property (nonatomic, strong) NSArray *teams;
//@property (nonatomic, strong) NSMutableArray *teamNames;

@end

@implementation AUDLTeamsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLTeamTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = 80;
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Add a gesture recognizer for the navigation sidebar
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //get teams
    [self teamsRequest];
    
    // Add a gesture recognizer to the table view for the cell selection
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    [self.view addGestureRecognizer:gesture];
    self.navigationController.navigationBar.translucent = NO;
    //[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.title = @"Teams";
    
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
    return [self.teams count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *thisTeam = [self.teams objectAtIndex:indexPath.row];
    // cell identifier is also team name
    NSString *cellIdentifier = @"Cell";
    // team ID
    NSString *cellTeamId = [thisTeam objectAtIndex:1];
    AUDLTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }


    
    // Configure the cell...
    [cell setTeamId:[NSString stringWithFormat: @"%@", cellTeamId]];
    cell.teamName.text = [thisTeam objectAtIndex:0];
    
    // show the team's logo to the left of their name
    AUDLAppDelegate *appDelegate = (AUDLAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *tempDict = appDelegate.icons;
    cell.teamLogo.image = [tempDict objectForKey:cell.teamId];
    cell.dividerView.clipsToBounds = YES;
    cell.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greybar_nodiv.png"]];
    cell.bgView.frame = cell.frame;
    cell.bgView.backgroundColor = [UIColor clearColor];
    cell.bgView.opaque = NO;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = cell.bgView;
    // add the right pointing arrow to the cell
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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



- (void)teamsRequest
{

    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Teams";
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
    _teams = [NSJSONSerialization
                JSONObjectWithData:urlData
                options:0
                error:&error];
}

- (void)didSelect:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint tapLocation = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
        UITableViewCell* tappedCell = [self.tableView cellForRowAtIndexPath:tappedIndexPath];
        
        // pointer to the cell that was selected
        AUDLTeamTableViewCell *selectedCell = (AUDLTeamTableViewCell*)tappedCell;
        NSLog(@"%@", selectedCell.teamId);
        // opens the selected cell's url in Safari
        
        
        // create the view controller we want to present
        AUDLIndivTeamTabViewController *teamSelection = [[AUDLIndivTeamTabViewController alloc] initWithId:selectedCell.teamId];
        teamSelection.teamName = selectedCell.teamName;
        
        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        // present the new view controller
        [self.navigationController pushViewController:teamSelection animated:YES];
        
      }
}



@end
