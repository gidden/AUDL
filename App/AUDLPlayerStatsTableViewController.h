//
//  AUDLPlayerStatssTableViewController.h
//  AUDL
//
//  Created by Evan Rypel on 4/17/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLPlayerStatsTableViewController : UITableViewController

@property (nonatomic, strong) NSString *stat;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (nonatomic, strong) NSArray *top;
@property id delegate;

-(id)initWithTop5:(NSArray *)top;

@end
