//
//  AUDLGameStatsView.m
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLGameStatsView.h"


@implementation AUDLGameStatsView

-(void) viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self createStatView];
}


-(void) createStatView
{
    
    UIView *statView = [[UIView alloc] init];
    
    [self.view addSubview:statView];

}
@end
