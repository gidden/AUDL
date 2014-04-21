//
//  AUDLSettingsTableViewController.m
//  App
//
//  Created by Evan Rypel on 3/21/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLSettingsTableViewController.h"
#import "AUDLTableViewCell.h"
#import "SWRevealViewController.h"
#import "AUDLFAQViewController.h"

@interface AUDLSettingsTableViewController ()

@end

@implementation AUDLSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
    [self.view addGestureRecognizer:gesture];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    //title page
    self.title = @"Settings";
    
    //list of settings
    _Setting = @[@"FAQ",
                 @"Terms of Use",
                 @"Notifications",
                 @"Send Feedback"];
    
    
    
    
   
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section (number of NSArray Settings).
    return [self.Setting count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self.Setting objectAtIndex:indexPath.row];
    
    AUDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[AUDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:cellIdentifier];
    cell.cellIdentifier = cellIdentifier;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didSelect:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint tapLocation = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
        UITableViewCell* tappedCell = [self.tableView cellForRowAtIndexPath:tappedIndexPath];
        
        // pointer to the cell that was selected
        AUDLTableViewCell* selectedCell = (AUDLTableViewCell*)tappedCell;
        NSLog(@"%@", selectedCell.cellIdentifier);
        
    
        
        UIViewController *controllerToShow;
        
        // create the view controller we want to present
        if ([selectedCell.cellIdentifier isEqualToString:@"FAQ"]) {
            AUDLFAQViewController *faq = [[AUDLFAQViewController alloc] init];
            controllerToShow = faq;
            
            
            
            
            
        
        }
       
        
        // override the back button in the new controller from saying "Schedule"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        // present the new view controller
        [self.navigationController pushViewController:controllerToShow animated:YES];
        
    }
}



@end
