//
//  AUDLScoresTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/19/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLScoresTableViewController.h"
#import "SWRevealViewController.h"
#import "AUDLDivisionTableViewController.h"
#import "AUDLTableViewCell.h"

@interface AUDLScoresTableViewController ()

@end

@implementation AUDLScoresTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Change button color
    _sideBarButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sideBarButton.target = self.revealViewController;
    _sideBarButton.action = @selector(revealToggle:);
    
    // Add a gesture recognizer for the navigation sidebar
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Get score items from the server
    [self scoreRequest];
    
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
    
    NSInteger divCount = [self.scores count]; //the number of divisions to loop over
    
    NSArray *thisDivisonInfo; // array for a divisions info (name and game sched.)
    NSString *divName; // string for division name
    NSArray *divSchedule; // array for the game sched.
    UITabBarItem *thisDivTab; //a tab bar item for the division
    NSArray *tabViewControllers = [NSArray array]; //array of the view controllers to hand to the tabbed view
    
    //loop over our divisions
    for (NSInteger i=0; i<divCount; i++) {
        
        //get the first schedule from the json data we loaded
        thisDivisonInfo = [self.scores objectAtIndex:i];
        
        //get the division name
        divName = [thisDivisonInfo objectAtIndex:0];
        // get the division's schedule info
        divSchedule = [thisDivisonInfo objectAtIndex:1];
        
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
        AUDLDivisionTableViewController *divScheduleView = [[AUDLDivisionTableViewController alloc] initWithSchedule:divSchedule];
        //set the tab bar item
        divScheduleView.tabBarItem = thisDivTab;
        
        //add this view to the array of view controllers
        tabViewControllers = [tabViewControllers arrayByAddingObject:divScheduleView];
        
    }
    
    self.tabBar.translucent = NO;
    //[self.tabBar setBarStyle:UIBarStyleBlack];
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


- (void)scoreRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Scores";
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
    _scores = [NSJSONSerialization
                 JSONObjectWithData:urlData
                 options:0
                 error:&error];
}

- (void)didSelect:(UIGestureRecognizer *)gestureRecognizer {
}

@end
