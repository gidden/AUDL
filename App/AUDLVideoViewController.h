//
//  AUDLVideoViewController.h
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLMainViewController.h"

@interface AUDLVideoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSArray *videos;

- (void) getVideos;
@end
