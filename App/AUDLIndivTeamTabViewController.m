//
//  AUDLIndivTeamTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/10/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLIndivTeamTabViewController.h"
#import "AUDLTableViewCell.h"
#import "AUDLRosterTableViewController.h"
#import "AUDLTeamScheduleTableViewController.h"
#import "AUDLTeamStatsTableViewController.h"
#import "AUDLDivisionScheduleTableViewController.h"
#import "AUDLDivisionScoreTableViewController.h"



@implementation AUDLIndivTeamTabViewController



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
    
    
  }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
}

- (UITableViewController*)getTeamViewController:(NSString *)tabTitle
{
    
 
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

        }

        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        


    return controllerToShow;
    
}

@end
