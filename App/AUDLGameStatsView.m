//
//  AUDLGameStatsView.m
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLGameStatsView.h"
#import "AUDLAppDelegate.h"
#import "AUDLGameStatViewCell.h"
#import "Globals.h"

@implementation AUDLGameStatsView

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self gameDataRequest];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self populateStatView];
}


-(void) populateStatView
{
//    UILabel *team2Name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
//    team2Name.text = [self.gameData objectAtIndex:1];
    self.team1Name.text = [self.gameData objectAtIndex:0];
    self.team2Name.text = [self.gameData objectAtIndex:1];
    self.team1Score.text = [NSString stringWithFormat:@"%@",[self.gameData objectAtIndex:2]];
    self.team2Score.text = [NSString stringWithFormat:@"%@",[self.gameData objectAtIndex:3]];
    self.team1Logo.image = self.team1Image;
    self.team2Logo.image = self.team2Image;
    
    //setup the stat table view
    CGRect thisFrame = self.view.frame;
    CGRect tableFrame = CGRectMake(thisFrame.origin.x, thisFrame.origin.y + (thisFrame.size.height/2), thisFrame.size.width, thisFrame.size.height);
    self.statTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.statTable.delegate = self;
    self.statTable.dataSource = self;
    self.statTable.scrollEnabled = NO;
    [self.statTable registerNib:[UINib nibWithNibName:@"AUDLGameStatViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.statTable];
    self.statData = [self.gameData objectAtIndex:4];
    
    if (self.statTable == nil)
    {
        NSLog(@"Table view not found.");
    }
    if ( self.team2Image == nil)
    {
        NSLog(@"No team 1 logo image.");
    }
    //    [self.view addSubview:team2Name];
}

// Function for getting all available game stat data from the AUDL server
- (void)gameDataRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Game/";
    path = [path stringByAppendingString:self.gameID];
    NSString *full_url = [server_url stringByAppendingString: path];
    
    NSURL *url = [[NSURL alloc] initWithString:full_url];
    
    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:
                                NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval: 30];
    
    // Prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    // Construct Array around the Data from the response
    NSArray *gameData = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:0
                         error:&error];
    
    //store data on this view controller
    self.gameData = gameData;
    
    
}


#pragma mark - UITableViewDataSource Methods

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
    
    //NSLog(@"Number of stats %z",[[self.statData objectAtIndex:0] count]);
    //return  [[self.statData objectAtIndex:0] count];
    return [[self.statData objectAtIndex:1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Got here.");
    NSString *cellID = @"Cell";
    
    
    AUDLGameStatViewCell *cell = [self.statTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[AUDLGameStatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.label1.text = [[[self.statData objectAtIndex:0] objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.label2.text = [[[self.statData objectAtIndex:0] objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.label3.text = [[[self.statData objectAtIndex:1] objectAtIndex:indexPath.row] objectAtIndex:1];
    //cell.textLabel.text = @"Test";
    
    return cell;
    
}

@end
