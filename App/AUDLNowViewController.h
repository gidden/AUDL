//
//  AUDLNowViewController.h
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLMainViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface AUDLNowViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong,nonatomic) UIWebView *webView;

@end
