//
//  TeamViewController.h
//  App
//
//  Created by Evan Rypel on 3/30/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLTeamsTableViewController.h"
#import "Globals.h"

@interface TeamViewController : AUDLTeamsTableViewController
    //NSString *teamName;


@property (nonatomic, strong) NSString *teamName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) NSArray *teamList;
@property (nonatomic, strong) NSArray *indivTeam;
@property id delegate;


- (id)initWithTeam:(NSArray *)teamList;

- (void)indivTeamRequest;

@end
