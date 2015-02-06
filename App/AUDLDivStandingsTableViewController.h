//
//  AUDLDivStandingsTableViewController.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/10/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLDivStandingsTableViewController : UITableViewController
@property (nonatomic, strong) NSString *division;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) NSArray *standings;
@property id delegate;

- (id)initWithStandings:(NSArray *)standings;



@end
