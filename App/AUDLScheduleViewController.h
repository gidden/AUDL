//
//  AUDLScheduleViewController.h
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
@interface AUDLScheduleTableViewController : UITabBarController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSArray *schedule;

- (void)scheduleRequest;
- (void)didSelect:UIGestureRecognizer;

@end
