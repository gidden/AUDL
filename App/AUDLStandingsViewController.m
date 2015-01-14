//
//  AUDLStandingsViewController.m
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLStandingsViewController.h"
#import "SWRevealViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLDivStandingsTableViewController.h"

@interface AUDLStandingsTableViewController ()

@end

@implementation AUDLStandingsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    //change color of button
    _sidebarButton.tintColor = [UIColor colorWithRed:0 green:122.0/225.0 blue:1.0 alpha:1.0];
    
    //set side bar button acton. when tapped, sidebar appears
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    //set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Get standings items from the server
    [self standingsRequest];
    
    // Add a gesture recognizer to the table view for the cell selection
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    [self.view addGestureRecognizer:gesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.standings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *thisStandings = [self.standings objectAtIndex:indexPath.row];
    
    // the first element, the cellIdentifier, is the division name
    NSString *cellIdentifier = [thisStandings objectAtIndex:0];
    
    // the next elements, divTeams, is the divison's teams
    NSMutableArray *divTeams = [[NSMutableArray alloc] init];
    for(int i=1; i< thisStandings.count; i++){
        [divTeams addObject:[thisStandings objectAtIndex:i]];
    }
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    [cell setDivTeams:divTeams];
    [cell setDivisionName:cellIdentifier];
    
    // add the right pointing arrow to the cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)standingsRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Standings";
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
    
    // Construct Array around the Data from the response
    _standings = [NSJSONSerialization
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
        AUDLTableViewCell* selectedCell = (AUDLTableViewCell*)tappedCell;
        for (int i=0; i<selectedCell.divTeams.count; i++) {
            NSLog(@"%@", selectedCell.divTeams[i]);
        }
        
        // create the view controller we want to present
        AUDLDivStandingsTableViewController *division = [[AUDLDivStandingsTableViewController alloc] initWithSchedule:selectedCell.divTeams];
        division.division = [selectedCell.divisionName stringByAppendingString:@" Division"];
        
        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        // present the new view controller
        [self.navigationController pushViewController:division animated:YES];
        
    }
}

@end
