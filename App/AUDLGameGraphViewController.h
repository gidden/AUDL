//
//  AUDLGameGraphViewController.h
//  AUDL
//
//  Created by Patrick on 1/15/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "CorePlot-CocoaTouch.h"


@interface AUDLGameGraphViewController: UIViewController <CPTPlotDataSource>

@property (strong, nonatomic) IBOutlet UILabel *noGraph;
@property (strong, nonatomic) NSString *gID;

@property (strong, nonatomic) NSArray *team1pnts;
@property (strong, nonatomic) NSArray *team2pnts;
@property (strong, nonatomic) NSString *team1;
@property (strong, nonatomic) NSString *team2;

@property (nonatomic) CGRect graphBounds;

- (id)initWithID:(NSString *) gID;

@end