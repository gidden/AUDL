//
//  AUDLNewsWebViewController.m
//  AUDL
//
//  Created by Patrick on 1/20/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import "AUDLNewsWebViewController.h"

@implementation AUDLNewsWebViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];

    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.webView = [[UIWebView alloc] init];
    [self.webView setFrame:self.view.bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.webView action:@selector(goBack)];
    
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.webView action:@selector(goForward)];
    
    NSArray *tBarItems = [[NSArray alloc] initWithObjects:forwardButton,backButton,nil];
    
    
    [self.navigationItem setRightBarButtonItems:tBarItems animated:YES];
    
 
    
    
    
    [[self view] addSubview:self.webView];

    
}

@end