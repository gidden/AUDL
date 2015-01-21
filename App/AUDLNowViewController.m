//
//  AUDLNowViewController.m
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLNowViewController.h"
#import "SWRevealViewController.h"
//#import <Accounts/Accounts.h>
//#import <Social/Social.h>
//#import "STTwitter.h"
//#import "AUDLTwitterViewCell.h"
//#import <Twitter/Twitter.h>

@interface AUDLNowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *twitterTableView;
@property (strong, nonatomic) NSMutableArray *twitterFeed;


@end

@implementation AUDLNowViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //change color of button
    
    //add the menu button to the navigation bar
    self.sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
    [self.navigationItem setLeftBarButtonItem:self.sidebarButton animated:YES];
    
    //set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
 
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.webView = [[UIWebView alloc] init];
    [self.webView setFrame:self.view.bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile.twitter.com/theaudl"]]];
   
    UIToolbar *tBar = [[UIToolbar alloc] init];
    tBar = UIBarStyleDefault;
    [tBar sizeToFit];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.webView action:@selector(goBack)];
  
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.webView action:@selector(goForward)];

    NSArray *tBarItems = [[NSArray alloc] initWithObjects:forwardButton,backButton,nil];
    
    
    [self.navigationItem setRightBarButtonItems:tBarItems animated:YES];
    
    
    [[self view] addSubview:self.webView];

    
    
}

-(void)goBack
{

    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}


-(void)goForward
{
    if ([self.webView canGoForward])
    {
        [self.webView goForward];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
