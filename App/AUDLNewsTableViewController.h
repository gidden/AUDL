//
//  AUDLNewsTableViewController.h
//  App
//
//  Created by Ryan Zoellner on 3/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLNewsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (void)getNewsItems;

@end
