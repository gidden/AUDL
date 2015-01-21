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
    UIWebView *webView = [[UIWebView alloc] init];
    [webView setFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
    [[self view] addSubview:webView];

    
}

@end