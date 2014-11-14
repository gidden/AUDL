//
//  AUDLStatsViewController.m
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLStatsViewController.h"
#import "SWRevealViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLPlayerStatsTableViewController.h"

@interface AUDLStatsTableViewController ()

@end

@implementation AUDLStatsTableViewController

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
    
    //get player stats from server
    [self playerStatsRequest];
   
    /*_assists = [_playerStats objectForKey:@"Assists"];
    _throwaways = [_playerStats objectForKey:@"Throwaways"];
    _goals = [_playerStats objectForKey:@"Goals"];
    _pmc = [_playerStats objectForKey:@"PMC"];
    _drops = [_playerStats objectForKey:@"Drops"];
    _ds = [_playerStats objectForKey:@"Ds"];
     */
    _statDescription = @[@"Throwaways", @"Assists", @"Goals", @"PMC", @"Drops", @"Ds"];
    
    // change the title; helps differentiate from team stats
    self.navigationItem.title = @"League Leader Stats";
    
    //set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
    
    // Return the number of rows in the section.
    
    return [self.playerStats count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *thisStats = [self.statDescription objectAtIndex:indexPath.row];
    //NSLog(@"populating first page");
    // the first element, the cellIdentifier, is the division name
    NSString *cellIdentifier = thisStats;
    
    // the second element, divSchedule, is the divison's schedule
    //NSLog(@"getting each page's top 5");
    NSArray *top5 = [_playerStats objectForKey:thisStats];
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    //NSLog(@"Configuring the cell");
    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    [cell setTop5:top5];
    [cell setStatName:cellIdentifier];
    
    // add the right pointing arrow to the cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

- (void)playerStatsRequest
{
    // Prepare the link that is going to be used on the GET request
    NSURL * url = [[NSURL alloc] initWithString:@"http://ec2-54-86-111-95.us-west-2.compute-1.amazonaws.com:4001/Stats"];
    
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
    _playerStats = [NSJSONSerialization
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
        //for (int i=0; i<selectedCell.top5.count; i++) {
        //    NSLog(@"%@", selectedCell.top5[i]);
        //}
        
        // create the view controller we want to present
        AUDLPlayerStatsTableViewController *top5 = [[AUDLPlayerStatsTableViewController alloc] initWithTop5:selectedCell.top5];
        
        // set the name of this stat
        top5.stat = selectedCell.statName;
        
        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        // present the new view controller
        [self.navigationController pushViewController:top5 animated:YES];
    }
}

@end
