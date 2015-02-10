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
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Get standings items from the server
    [self standingsRequest];
    
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
    NSString *baseIconPath = [server_url stringByAppendingString:@"/Images/iOS/"];
    
    NSInteger divCount = [self.standings count]; //the number of divisions to loop over

    NSMutableArray *thisDivisonInfo; // array for a divisions info (name and game sched.)
    NSString *divName; // string for division name
    NSArray *divStandings; // array for the game sched.
    UITabBarItem *thisDivTab; //a tab bar item for the division
    NSArray *tabViewControllers = [NSArray array]; //array of the view controllers to hand to the tabbed view
    
    //loop over our divisions
    for (NSInteger i=0; i<divCount; i++) {
        
        //get the first schedule from the json data we loaded
        thisDivisonInfo = [[NSMutableArray alloc] initWithArray:[self.standings objectAtIndex:i]];
        
        //get the division name
        divName = [thisDivisonInfo objectAtIndex:0];
        // get the division's schedule info
        [thisDivisonInfo removeObjectAtIndex:0];
        divStandings = [[NSArray alloc] initWithArray:thisDivisonInfo];
        
        //setup images for the tab bar item
        //selected image
        NSString *onFilename = [baseIconPath stringByAppendingString:divName];
        onFilename = [onFilename stringByAppendingString:@"-On-Small.png"];
        NSURL *onURL = [NSURL URLWithString:onFilename];
        NSData *onData = [NSData dataWithContentsOfURL:onURL];
        UIImage *onImage = [UIImage imageWithData:onData];
        onImage = [onImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //make sure our selected image appears without tint overlay
        
        //unselected tab image
        NSString *offFilename = [baseIconPath stringByAppendingString:divName];
        offFilename = [offFilename stringByAppendingString:@"-Off-Small.png"];
        NSURL *offURL = [NSURL URLWithString:offFilename];
        NSData *offData = [NSData dataWithContentsOfURL:offURL];
        UIImage *offImage = [UIImage imageWithData:offData];
        
        //add a tab bar item for this division
        thisDivTab = [[UITabBarItem alloc] initWithTitle:@"" image:offImage selectedImage:onImage];

        //create a division view controller
        AUDLDivStandingsTableViewController *divScheduleView = [[AUDLDivStandingsTableViewController alloc] init];
        [divScheduleView setStandings:divStandings];
        [divScheduleView setDivision:divName];
        
        //set the tab bar item
        divScheduleView.tabBarItem = thisDivTab;
        
        //add this view to the array of view controllers
        tabViewControllers = [tabViewControllers arrayByAddingObject:divScheduleView];
 
    }

    self.tabBar.translucent = NO;
 
    //setup the array of view controllers for the tabbed view
    self.viewControllers = tabViewControllers;
    
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

@end
