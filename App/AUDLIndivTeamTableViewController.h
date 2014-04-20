//
//  AUDLIndivTeamTableViewController.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/10/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLIndivTeamTableViewController : UITableViewController
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *teamId;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *teamMenu;
@property (nonatomic, strong) NSArray *teamInfo;


@property id delegate;

- (id)init;
- (void)teamRequest;


@end
