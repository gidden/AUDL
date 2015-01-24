//
//  AUDLScheduleViewController.m
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLScheduleViewController.h"
#import "AUDLDivisionTableViewController.h"
#import "SWRevealViewController.h"
#import "AUDLTableViewCell.h"



@interface AUDLScheduleTableViewController ()

@end

@implementation AUDLScheduleTableViewController

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
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Add a gesture recognizer for the navigation sidebar
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    // Get news items from the server
    [self scheduleRequest];
    
    
    // Add a gesture recognizer to the table view for the cell selection
    //UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];

    //[self.view addGestureRecognizer:gesture];
    
    //add view controllers to the tabbed view
    NSString *baseIconPath = [server_url stringByAppendingString:@"/Images/iOS/"];
    
    NSInteger divCount = [self.schedule count]; //the number of divisions to loop over
    
    NSArray *thisDivisonInfo; // array for a divisions info (name and game sched.)
    NSString *divName; // string for division name
    NSArray *divSchedule; // array for the game sched.
    UITabBarItem *thisDivTab; //a tab bar item for the division
    NSArray *tabViewControllers = [NSArray array]; //array of the view controllers to hand to the tabbed view
    
    //loop over our divisions
    for (NSInteger i=0; i<divCount; i++) {
    
    //get the first schedule from the json data we loaded
    thisDivisonInfo = [self.schedule objectAtIndex:i];
    
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

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    //#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//   
//    // Return the number of rows in the section.
//    
//    return [self.schedule count];
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSArray *thisSchedule = [self.schedule objectAtIndex:indexPath.row];
//    
//    // the first element, the cellIdentifier, is the division name
//    NSString *cellIdentifier = [thisSchedule objectAtIndex:0];
//    
//    // the second element, divSchedule, is the divison's schedule
//    NSArray *divSchedule = [thisSchedule objectAtIndex:1];
//    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    // Configure the cell...
//    NSString *textToDisplay = [cellIdentifier stringByAppendingString:@" Division"];
//    cell.textLabel.text = textToDisplay;
//    [cell setDivSchedule:divSchedule];
//    [cell setDivisionName:cellIdentifier];
//    
//    // add the right pointing arrow to the cell
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
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


- (void)scheduleRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Schedule";
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
    _schedule = [NSJSONSerialization
                  JSONObjectWithData:urlData
                  options:0
                  error:&error];
}

- (void)didSelect:(UIGestureRecognizer *)gestureRecognizer {
    
}
//
//    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        CGPoint tapLocation = [gestureRecognizer locationInView:self.tableView];
//        NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
//        UITableViewCell* tappedCell = [self.tableView cellForRowAtIndexPath:tappedIndexPath];
//        
//        // pointer to the cell that was selected
//        AUDLTableViewCell* selectedCell = (AUDLTableViewCell*)tappedCell;
//        for (int i=0; i<selectedCell.divSchedule.count; i++) {
//            NSLog(@"%@", selectedCell.divSchedule[i]);
//        }
//        
//        // create the view controller we want to present
//        AUDLDivisionTableViewController *divSchedule = [[AUDLDivisionTableViewController alloc] initWithSchedule:selectedCell.divSchedule];
//        
//        divSchedule.division = selectedCell.divisionName;
//        NSLog(@"%@", divSchedule.division);
//        
//        // select the transition style
//        //divSchedule.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        
//        // set the presenting view controller to this controller
//        //divSchedule.delegate = self;
//        
//        // Create the navigation controller and present it.
//        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:divSchedule];
//        
//        // override the back button in the new controller from saying "Schedule"
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
//        self.navigationItem.backBarButtonItem = backButton;
//        
//        // present the new view controller
//        [self.navigationController pushViewController:divSchedule animated:YES];
//    }
//}





@end
