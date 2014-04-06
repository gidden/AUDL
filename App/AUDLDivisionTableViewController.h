//
//  AUDLDivisionTableViewController.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/6/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLDivisionTableViewController : UITableViewController

@property (nonatomic, strong) NSString *division;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) NSArray *schedule;
@property id delegate;

- (id)initWithSchedule:(NSArray *)schedule;

@end
