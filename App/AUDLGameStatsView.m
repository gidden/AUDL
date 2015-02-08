//
//  AUDLGameStatsView.m
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLGameStatsView.h"
#import "AUDLAppDelegate.h"
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
    self.team1Logo.image = self.team1Image;
    self.team2Logo.image = self.team2Image;
    
    if ( self.team2Image == nil)
    {
        NSLog(@"No team 1 logo image.");
    }
    //    [self.view addSubview:team2Name];
}

// Function for getting all available game graph data from the AUDL server
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


@end
