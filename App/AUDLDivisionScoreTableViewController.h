//
//  AUDLDivisionScoreTableViewController.h
//  AUDL
//
//  Created by Patrick on 1/25/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLDivisionScoreTableViewController : UITableViewController

@property (nonatomic, strong) NSString *division;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) NSArray *schedule;
@property id delegate;

- (id)initWithSchedule:(NSArray *)schedule;

@end
