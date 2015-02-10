//
//  AUDLTeamStatsTableViewController.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTeamStatsTableViewController : UITableViewController
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *teamCity;
@property (nonatomic, strong) NSString *teamId;
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, strong) NSArray *teamStats;
@property (nonatomic, strong) NSMutableArray *sectionBools;
@end
