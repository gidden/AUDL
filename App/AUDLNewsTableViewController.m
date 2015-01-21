//
//  AUDLNewsTableViewController.m
//  App
//
//  Created by Ryan Zoellner on 3/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLNewsTableViewController.h"
#import "SWRevealViewController.h"
#import "AUDLNewsTableViewCell.h"
#import "AUDLNewsWebViewController.h"
#import "AUDLAppDelegate.h"
#import "Globals.h"

//#import "Globals.h"

@interface AUDLNewsTableViewController ()

//@property (nonatomic, strong) NSArray *newsItems;

@end

@implementation AUDLNewsTableViewController

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
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Get news items from the server
    [self newsItemsRequest];
    
    //register with the view cell class
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    self.tableView.rowHeight = 120;

    // Add a gesture recognizer to the table view for the cell selection
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    [self.view addGestureRecognizer:gesture];
    
    // Add pull-to-refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    //(AUDLAppDelegate *)[[UIApplication sharedApplication].delegate.
    
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
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    // The "-1" is due to the JSON response's header "AUDL News"
    // newsItems[0] = "AUDL News"
    // newsItems[1] = first story to display
    return [self.newsItems count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "+1" is to start at first story, not the header
    NSArray *thisNewsItem = [self.newsItems objectAtIndex:indexPath.row+1];
    NSString *cellIdentifier = @"NewsCell";
    NSString *cellText = [thisNewsItem objectAtIndex:0];
    NSString *cellLink = [thisNewsItem objectAtIndex:1];
    AUDLNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    
    // for now, use the AUDL logo as the news thumbnail
    cell.imageView.image = [UIImage imageNamed:@"audl-30px.png"];
    
    //AUDLAppDelegate *appDelegate = (AUDLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //NSDictionary *tempDict = appDelegate.icons;
    
    //cell.imageView.image = [tempDict objectForKey:@"5182111044599808"];
    cell.artTitle.text = cellText;
    //[cell setArticleTitle:cellIdentifier];
    //NSLog(@"%@",cell.articleTitle);
    [cell setLink:cellLink];

    return cell;
}


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


- (void)newsItemsRequest
{
    NSLog(@"server request");
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/News";
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
    _newsItems = [[NSArray alloc] init];
    _newsItems = [NSJSONSerialization
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
        AUDLNewsTableViewCell* selectedCell = (AUDLNewsTableViewCell*)tappedCell;
    
        // opens the selected cell's url in Safari
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectedCell.link]];
        // present the new view controller
        // create the view controller we want to present
        AUDLNewsWebViewController *newsWebView = [[AUDLNewsWebViewController alloc] init];
        
        //set the web view link
        newsWebView.link = selectedCell.link;
        
        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;

        [self.navigationController pushViewController:newsWebView animated:YES];
        //[self.webview loadRequest:[NSURL URLWithString:selectedCell.link]];
    }
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self newsItemsRequest];
    [refreshControl endRefreshing];
}




@end
