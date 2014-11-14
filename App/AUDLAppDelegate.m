//
//  AUDLAppDelegate.m
//  App
//
//  Created by Ryan Zoellner on 3/13/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLAppDelegate.h"

@implementation AUDLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"app started");
    [self getIconsOnStart];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)getIconsOnStart
{
    [self teamsRequest];
    [self createTeamsDictionary];
}

- (void)teamsRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSURL * url = [[NSURL alloc] initWithString:@"http://ec2-54-86-111-95.compute-1.amazonaws.com:4001/Teams"];
    
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
    _teamsData = [NSJSONSerialization
              JSONObjectWithData:urlData
              options:0
              error:&error];
}

- (void)createTeamsDictionary
{
    
    _teamIds = [[NSMutableArray alloc] init];
    _teamIcons = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_teamsData count]; i++) {
        NSArray *tempArray = _teamsData[i];
        //NSString *tempTeamName = [tempArray objectAtIndex:0];
        NSString *tempTeamIdObject = [tempArray objectAtIndex:1];
        NSString *tempTeamId = [NSString stringWithFormat: @"%@", tempTeamIdObject];
        [_teamIds insertObject:tempTeamId atIndex:i];
        
        UIImage *tempTeamIcon = [self iconRequestWithTeamId:tempTeamId];
        [_teamIcons insertObject:tempTeamIcon atIndex:i];
    }
    
    // set up the dictionary
    _icons = [NSDictionary dictionaryWithObjects:_teamIcons forKeys:_teamIds];
    
    
}

- (UIImage *)iconRequestWithTeamId:(NSString *)teamId
{
    //NSLog(@"icon requested, %@", teamId);
    // Prepare the link that is going to be used on the GET request
    NSURL * url = [[NSURL alloc] initWithString:[@"http://ec2-54-86-111-95.compute-1.amazonaws.com:4001/Icons/" stringByAppendingString:teamId]];
    //NSLog(@"error here");

    // Prepare the request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    // Prepare the variables for the JSON response
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    // Make synchronous request
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&response error:&error];

    // Construct UIImage around the Data from the response
    UIImage *resultImage = [UIImage imageWithData:(NSData *)result];
   
    return resultImage;
    
}


@end
