//
//  AUDLSettingsTableViewController.m
//  App
//
//  Created by Evan Rypel on 3/21/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLSettingsTableViewController.h"
#import "AUDLTableViewCell.h"
#import "SWRevealViewController.h"

@interface AUDLSettingsTableViewController ()

@end

@implementation AUDLSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    //title page
    self.title = @"Settings";
    
    //list of settings
    _Setting = @[@"setting 1",
                 @"setting 2",
                 @"setting 3",
                 @"setting 4",
                 @"setting 5",
                 @"setting 6",];
    
    
    
    
   
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section (number of NSArray Settings).
    return [self.Setting count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *thisSetting = [self.Setting objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [thisSetting objectAtIndex:0];
    NSString *cellSettingId = [thisSetting objectAtIndex:1];
    
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
       cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //configure the cell
    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    [cell setSetting:cellSettingId];
    
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *settings = [self.Setting objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [settings objectAtIndex:0];
    AUDLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    int row = [indexPath row];
    cell.SettingLabel = _Setting[row];
    return cell;
    /*
    NSArray *thisTeam = [self.teams objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [thisTeam objectAtIndex:0];
    NSString *cellTeamId = [thisTeam objectAtIndex:1];
    
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    [cell setTeamId:cellTeamId];
    
    return cell;
     */
    /*
     NSArray *settings = [self.Setting objectAtIndex:indexPath.row];
     NSString *cellIdentifier = [settings objectAtIndex:0];
     
     AUDLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
     
     // Configure the cell...
     cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
     [cell setSettingLabel:cellIdentifier];
     
     return cell;

}

*/
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)settingRequest
{
    //prepare the link that is going to be used on the GET request
    NSURL * url = [[NSURL alloc] initWithString:@"http://ec2-54-186-184-48.us-west-2.compute.amazonaws.com:4000/Settings"];
    
    //prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    
    //prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    //make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    //construct array around the data from the response
    _Setting = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
}


@end
