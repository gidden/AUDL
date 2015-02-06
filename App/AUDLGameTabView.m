//
//  AUDLGameTabView.m
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLGameTabView.h"
#import "AUDLGameGraphViewController.h"


@implementation AUDLGameTabView


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self setupTabView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupTabView];
}
- (id)initWithGameID:(NSString *) ID
{
    self = [super init];
    // set the graphView's game id value
    if (self) {
        self.gameID = ID;
    }
    return self;
}



- (void)setupTabView{

    NSArray *tabViewControllers = [NSArray array]; //array of the view controllers to hand to the tabbed view

    //add the graph view to the list of tab views

    // create the view controller we want to present
    AUDLGameGraphViewController *gameGraphView = [[AUDLGameGraphViewController alloc] initWithGameID:self.gameID];

    
    //add a tab bar item for this division
    UITabBarItem *thisDivTab = [[UITabBarItem alloc] initWithTitle:@"Graph" image:nil selectedImage:nil];

    gameGraphView.tabBarItem = thisDivTab;
    
    //add this view to the array of view controllers
    tabViewControllers = [tabViewControllers arrayByAddingObject:gameGraphView];
    
    
    self.tabBar.translucent = NO;
    //[self.tabBar setBarStyle:UIBarStyleBlack];
    //setup the array of view controllers for the tabbed view
    self.viewControllers = tabViewControllers;
}

@end

