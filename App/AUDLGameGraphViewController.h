//
//  AUDLGameGraphViewController.h
//  AUDL
//
//  Created by Patrick on 1/15/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLGameGraphViewController: UIViewController

@property (strong, nonatomic) IBOutlet UILabel *gameID;
@property (strong, nonatomic) NSString *gID;

- (id)initWithID:(NSString *) gID;

@end