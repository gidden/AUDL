//
//  AUDLVideoViewController.m
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLVideoViewController.h"
#import "SWRevealViewController.h"
#import "AUDLTableViewCell.h"

@interface AUDLVideoTableViewController ()

@end

@implementation AUDLVideoTableViewController

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
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //get videos from server
    [self getVideos];
    
    // Add a gesture recognizer to the table view for the cell selection
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    [self.view addGestureRecognizer:gesture];
    
    // Add pull-to-refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getVideos
{
    
    // Prepare the link that is going to be used on the GET request
    NSURL * url = [[NSURL alloc] initWithString:@"http://ec2-54-186-184-48.us-west-2.compute.amazonaws.com:4000/Videos"];
    
    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
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
    _videos = [NSJSONSerialization
              JSONObjectWithData:urlData
              options:0
              error:&error];

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
    return [self.videos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *thisVideo = [self.videos objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [thisVideo objectAtIndex:0];
    NSString *cellVideoId = [thisVideo objectAtIndex:1];
    NSString *cellThumbnailURL = [thisVideo objectAtIndex:2];
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    [cell setVideoId:cellVideoId];
    
    UIImage *thumbnail = [self imageFromURLString:cellThumbnailURL];
    cell.imageView.image = thumbnail;
    
    return cell;
}

- (void)didSelect:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint tapLocation = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
        UITableViewCell* tappedCell = [self.tableView cellForRowAtIndexPath:tappedIndexPath];
        
        // pointer to the cell that was selected
        AUDLTableViewCell* selectedCell = (AUDLTableViewCell*)tappedCell;
        
        // opens the selected cell's url in Safari
        // in the simulator, it will open in Safari since YouTube app is not present
        // on a device, it will open in thr YouTube app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectedCell.videoId]];
    }
}


// method to get the thumbnails from their URL
- (UIImage *)imageFromURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&response error:&error];
    //[self handleError:error];
    UIImage *resultImage = [UIImage imageWithData:(NSData *)result];
    
    //NSLog(@"urlString: %@",urlString);
    return resultImage;
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getVideos];
    [refreshControl endRefreshing];
}

@end
