//
//  AUDLStatsViewController.h
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@interface AUDLStatsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSDictionary *playerStats;
@property (nonatomic, strong) NSMutableArray *sectionBools;
@property (nonatomic, strong) NSArray *throwaways;
@property (nonatomic, strong) NSArray *assists;
@property (nonatomic, strong) NSArray *goals;
@property (nonatomic, strong) NSArray *pmc;
@property (nonatomic, strong) NSArray *drops;
@property (nonatomic, strong) NSArray *ds;
@property (nonatomic, strong) NSArray *statDescription;

- (void) playerStatsRequest;

@end
