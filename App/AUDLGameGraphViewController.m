//
//  AUDLGameGraphViewController.m
//  AUDL
//
//  Created by Patrick on 1/15/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//


#import "AUDLGameGraphViewController.h"

@implementation AUDLGameGraphViewController

- (void)awakeFromNib
{
    // Initialization code
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.gameID.text = self.gID;
}

- (id)initWithID:(NSString *) ID
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.gID = ID;
    }
    
    NSLog(self.gID);
    return self;
 
    
}
@end
