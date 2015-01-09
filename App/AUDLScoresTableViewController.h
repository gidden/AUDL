//
//  AUDLScoresTableViewController.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/19/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h" 

@interface AUDLScoresTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (nonatomic, strong) NSArray *scores;

- (void)scoreRequest;
- (void)didSelect:UIGestureRecognizer;

@end
