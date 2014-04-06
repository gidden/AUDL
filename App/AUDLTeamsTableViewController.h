//
//  AUDLTeamsTableViewController.h
//  App
//
//  Created by Ryan Zoellner on 3/19/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTeamsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSArray *teams;
@property (nonatomic, strong) NSMutableArray *teamNames;

- (void)teamsRequest;

@end
