//
//  AUDLStatsViewController.h
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLStatsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSArray *playerStats;

- (void) playerStatsRequest;
@end
