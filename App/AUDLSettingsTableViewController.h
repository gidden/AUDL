//
//  AUDLSettingsTableViewController.h
//  App
//
//  Created by Evan Rypel on 3/21/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLSettingsTableViewController : UITableViewController


//sidebar button
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

//break table up into arrays
@property (nonatomic, strong) NSArray *Setting;
//@property (nonatomic, strong) NSArray *Switch;

@end

