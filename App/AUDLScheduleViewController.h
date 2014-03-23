//
//  AUDLScheduleViewController.h
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLScheduleTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton2;

- (void)getSchedule;

@end
