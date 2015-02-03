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
#import "AUDLTop5TableViewCell.h"
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLTop5TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    //change color of button
    _sidebarButton.tintColor = [UIColor colorWithRed:0 green:122.0/225.0 blue:1.0 alpha:1.0];
    
    //set side bar button acton. when tapped, sidebar appears
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    //get player stats from server
    [self playerStatsRequest];
   
     // change the title; helps differentiate from team stats
    self.navigationItem.title = @"League Leader Stats";
    
    //set the pan gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
 
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
    return [self.playerStats.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.

    return [[self.playerStats objectForKey:[self.playerStats.allKeys objectAtIndex:section]] count];
}

-(NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.playerStats.allKeys objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the stats key for this section
    NSString *thisStatName = [self.playerStats.allKeys objectAtIndex:indexPath.section];
    // get the list of stats
    NSArray *top5 = [_playerStats objectForKey:thisStatName];
    //Create a new cell instance
    NSString *cellIdentifier = @"Cell";

    AUDLTop5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTop5TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...get player's info for this cell from the stat list
    NSArray *playerInfo = [top5 objectAtIndex:indexPath.row];
    //Set the Cell's info
    cell.playerName.text = playerInfo[0];
    cell.number.text = [NSString stringWithFormat:@"%@", playerInfo[1]];
    
    return cell;

}

- (void)playerStatsRequest
{
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Stats";
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
    _playerStats = [NSJSONSerialization
                 JSONObjectWithData:urlData
                 options:0
                 error:&error];
}

@end
