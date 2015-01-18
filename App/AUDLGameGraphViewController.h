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

@property (strong, nonatomic) IBOutlet UILabel *gameID;
@property (strong, nonatomic) NSString *gID;

@property (nonatomic, strong) NSArray *gameData;

- (id)initWithID:(NSString *) gID;

@end