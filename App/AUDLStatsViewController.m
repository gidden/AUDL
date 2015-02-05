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
   
    
    //setup boolean array for collapsing sections
    self.sectionBools = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self.playerStats count]; i++)
    {
        [self.sectionBools addObject:[NSNumber numberWithBool:NO]];
    }
    
     // change the title; helps differentiate from team stats
    self.navigationItem.title = @"League Leader Stats";
    
    
    //Trick section headers into being anchored to cell views
    CGFloat dummyViewHeight = 40;
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, dummyViewHeight)];
    self.tableView.tableHeaderView = dummyView;
    self.tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0);

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
    if ([[self.sectionBools objectAtIndex:section] boolValue]) {
        return [[self.playerStats objectForKey:[self.playerStats.allKeys objectAtIndex:section]] count];
    }
    else
    {
        return 0;
    }
}

-(NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.playerStats.allKeys objectAtIndex:section];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.tag                  = section;
//    headerView.backgroundColor      = [UIColor whiteColor];
    
    //create a background image for the header
    UIImage *bg = [UIImage imageNamed:@"Blue_Bar"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bg];
    imageView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height);
    imageView.clipsToBounds = YES;

    BOOL manyCells = [[self.sectionBools objectAtIndex:section] boolValue];
    
//    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 50)];
//    headerString.text = [self.playerStats.allKeys objectAtIndex:section];
//    headerString.textAlignment      = NSTextAlignmentLeft;
//    headerString.textColor          = [UIColor blackColor];
//    [headerView addSubview:headerString];
    
    //create title for the section header
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 6, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    //remove date dashes and replace with .'s
    headerLabel.text = [self.playerStats.allKeys objectAtIndex:section];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    

    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 10, 30, 30);
    
    [headerView addSubview:headerLabel];
    [headerView addSubview:upDownArrow];
    [headerView addSubview:imageView];
    [headerView sendSubviewToBack:imageView];

    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
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
    
    
    //create a background image for the header
    UIImage *bg = [UIImage imageNamed:@"Header_No_Type"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bg];
    //imageView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height);
    imageView.clipsToBounds = YES;
    [cell setBackgroundView:imageView];
    
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

//Collapse section animation
#pragma mark - gesture tapped
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[self.sectionBools objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [self.sectionBools replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
