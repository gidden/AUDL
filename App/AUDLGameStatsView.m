//
//  AUDLGameStatsView.m
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLGameStatsView.h"
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
    
    self.team1Name.text = [self.gameData objectAtIndex:0];

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
