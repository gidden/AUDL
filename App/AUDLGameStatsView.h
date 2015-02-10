//
//  AUDLGameStatsView.h
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLGameStatsView : UIViewController <UITableViewDelegate, UITableViewDataSource >

@property (strong, nonatomic) NSString *gameID;
@property (strong, nonatomic) NSArray *gameData;

@property (strong, nonatomic) IBOutlet UILabel *team1Name;
@property (strong, nonatomic) IBOutlet UILabel *team2Name;
@property (strong, nonatomic) UIImage *team1Image;
@property (strong, nonatomic) UIImage *team2Image;
@property (strong, nonatomic) IBOutlet UIImageView *team1Logo;
@property (strong, nonatomic) IBOutlet UIImageView *team2Logo;
@property (weak, nonatomic) IBOutlet UILabel *team1Score;
@property (weak, nonatomic) IBOutlet UILabel *team2Score;
@property (strong, nonatomic) IBOutlet UITableView *statTable;
@property (strong,nonatomic) NSArray *statData;
@end