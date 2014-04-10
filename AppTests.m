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
    self.tearDown;
}





@end