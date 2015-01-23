//
//  AppTests.m
//  AppTests
//
//  Created by Ryan Zoellner on 3/13/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AUDLNewsTableViewController.h"
#import "AUDLTeamsTableViewController.h"
#import "AUDLScheduleViewController.h"
#import "AUDLStandingsViewController.h"
#import "AUDLVideoViewController.h"
#import "AUDLDivisionTableViewController.h"



@interface AppTests : XCTestCase

@end

@implementation AppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void)testNews
{
    AUDLNewsTableViewController *news = [[AUDLNewsTableViewController alloc] init];
    news.newsItemsRequest;
    NSArray *testNewsItems = news.newsItems;
    for (int i = 0; i < testNewsItems.count-1; i++) {
        NSArray *h = [testNewsItems objectAtIndex:i+1];
        NSString *item1 = [h objectAtIndex:0];
        NSString *item2 = [h objectAtIndex:1];
        NSLog(@"item 1: %@ item 2: %@", item1, item2);
    }
    
    UITableView *tableView = [[UITableView alloc] init];
    NSAssert([news numberOfSectionsInTableView:tableView] == 1, @"The numberOfSectionsInTableView is not equal to 1");
    
    NSAssert([news tableView:tableView numberOfRowsInSection:1] == testNewsItems.count-1, @"The numberOfRows in section is not equal to news.count");
    
    UIGestureRecognizer *myGesture = [[UIGestureRecognizer alloc] init];
    [news didSelect:myGesture];
    self.tearDown;
}

- (void)testVideo
{
    AUDLVideoTableViewController *videos = [[AUDLVideoTableViewController alloc] init];
    videos.getVideos;
    NSArray *testVideos = videos.videos;
    for (int i = 0; i < testVideos.count-1; i++) {
        NSArray *h = [testVideos objectAtIndex:i+1];
        NSString *item1 = [h objectAtIndex:0];
        NSString *item2 = [h objectAtIndex:1];
        NSLog(@"item 1: %@ item 2: %@", item1, item2);
    }
    
    UITableView *tableView = [[UITableView alloc] init];
    NSAssert([videos numberOfSectionsInTableView:tableView] == 1, @"The numberOfSectionsInTableView is not equal to 1");
    
    NSAssert([videos tableView:tableView numberOfRowsInSection:1] == testVideos.count, @"The numberOfRows in section is not equal to news.count");
    UIGestureRecognizer *myGesture = [[UIGestureRecognizer alloc] init];
    [videos didSelect:myGesture];
    self.tearDown;
}

- (void)testTeams
{
    AUDLTeamsTableViewController *teams = [[AUDLTeamsTableViewController alloc] init];
    teams.teamsRequest;
    NSArray *testTeams = teams.teams;
    for (int i = 0; i < testTeams.count; i++) {
        NSArray *h = [testTeams objectAtIndex:i];
        NSString *item1 = [h objectAtIndex:0];
        NSString *item2 = [h objectAtIndex:1];
        NSLog(@"item 1: %@ item 2: %@", item1, item2);
    }
    
    UITableView *tableView = [[UITableView alloc] init];
    NSAssert([teams numberOfSectionsInTableView:tableView] == 1, @"The numberOfSectionsInTableView is not equal to 1");
    
    NSAssert([teams tableView:tableView numberOfRowsInSection:1] == testTeams.count, @"The numberOfRows in section is not equal to teams.count");
    UIGestureRecognizer *myGesture = [[UIGestureRecognizer alloc] init];
    [teams didSelect:myGesture];
    
    self.tearDown;
}

- (void)testSchedule
{
    AUDLScheduleTableViewController *schedule = [[AUDLScheduleTableViewController alloc] init];
    schedule.scheduleRequest;
    NSArray *testSchedule = schedule.schedule;
    for (int i = 0; i < testSchedule.count; i++) {
        NSArray *h = [testSchedule objectAtIndex:i];
        NSString *item1 = [h objectAtIndex:0];
        NSString *item2 = [h objectAtIndex:1];
        NSLog(@"item 1: %@ item 2: %@", item1, item2);
    }
    
    UITableView *tableView = [[UITableView alloc] init];
    //NSAssert([schedule numberOfSectionsInTableView:tableView] == 1, @"The numberOfSectionsInTableView is not equal to 1");
    
    //NSAssert([schedule tableView:tableView numberOfRowsInSection:1] == testSchedule.count, @"The numberOfRows in section is not equal to schedule.count");
    UIGestureRecognizer *myGesture = [[UIGestureRecognizer alloc] init];
    //[schedule didSelect:myGesture];
    
    self.tearDown;
}

-(void)testInitWithSchedule

{
    
    NSArray * schedule = [[NSArray alloc] init];
    
    AUDLDivisionTableViewController *divTable = [[AUDLDivisionTableViewController alloc] initWithSchedule:schedule];
    
    if(divTable == nil){
        NSLog(@"initWithSchedule has wrong class id");
    }
    
    if(![divTable.navigationItem.title  isEqual: @"Division"]){
        NSLog(@"wrong title produced with initWithSchedule");
    }
    
    if(divTable.schedule != schedule){
        NSLog(@"wrong schedule added in initWithSchedule");
    }
    
    self.tearDown;
    
}


@end