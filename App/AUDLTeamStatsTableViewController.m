//
//  AUDLTeamStatsTableViewController.m
//  AUDL
//
//  Created by Ryan Zoellner on 4/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLTeamStatsTableViewController.h"
#import "AUDLTeamStatsTableViewCell.h"

@interface AUDLTeamStatsTableViewController ()

@end

@implementation AUDLTeamStatsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // use the xib created for team stats table cells
    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLTeamStatsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // each cell is height 150 in xib, so rowHeight must be 150 too
    self.tableView.rowHeight = 40;
    
    // nav title is currently "TeamName Statistics"
    self.navigationItem.title = self.navigationTitle;

    //setup boolean array for collapsing sections
    self.sectionBools = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self numberOfSectionsInTableView:self.tableView]; i++)
    {
        [self.sectionBools addObject:[NSNumber numberWithBool:NO]];
    }

    //Trick section headers into being anchored to cell views
    CGFloat dummyViewHeight = 40;
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, dummyViewHeight)];
    self.tableView.tableHeaderView = dummyView;
    self.tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0);
    self.tableView.allowsSelection = NO;
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
    return [self.teamStats count]-1;
}

-(NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *headerTitle = [[self.teamStats objectAtIndex:section+1] objectAtIndex:0];
    headerTitle = [headerTitle capitalizedString];
    //Adjust the statname for pmc (temporary)
        if ([headerTitle isEqualToString:@"Plusminuscount"]) {
            headerTitle = @"+/-";
        }

    return headerTitle;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.tag                  = section;
    //    headerView.backgroundColor      = [UIColor whiteColor];
    
    //create a background image for the header
    UIImage *bg = [UIImage imageNamed:@"Blue_Bar"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bg];
    imageView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height);
    imageView.clipsToBounds = YES;
    
    BOOL manyCells = [[self.sectionBools objectAtIndex:section] boolValue];
    
    //    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 50)];
    //    headerString.text = [self.playerStats.allKeys objectAtIndex:section];
    //    headerString.textAlignment      = NSTextAlignmentLeft;
    //    headerString.textColor          = [UIColor blackColor];
    //    [headerView addSubview:headerString];
    
    //create title for the section header
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 6, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    //remove date dashes and replace with .'s
    NSString *headerTitle = [[self.teamStats objectAtIndex:section+1] objectAtIndex:0];
    headerTitle = [headerTitle capitalizedString];
    //Adjust the statname for pmc (temporary)
    if ([headerTitle isEqualToString:@"Plusminuscount"]) {
        headerTitle = @"+/-";
    }

    headerLabel.text = headerTitle;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 10, 30, 30);
    
    [headerView addSubview:headerLabel];
    [headerView addSubview:upDownArrow];
    [headerView addSubview:imageView];
    [headerView sendSubviewToBack:imageView];
    
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // the first element is an info element on the current team
    
    // Return the number of rows in the section.
    if ([[self.sectionBools objectAtIndex:section] boolValue]) {
            return [[[self.teamStats objectAtIndex:section
                  +1] objectAtIndex:1] count];
    }
    else
    {
        return 0;
    }

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSString *cellIdentifier = @"Cell";
    
    AUDLTeamStatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[AUDLTeamStatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // "+1" is to start at first schedule item
    // index 0 is the current team's info
    NSArray *sectionStats = [[self.teamStats objectAtIndex:indexPath.section+1] objectAtIndex:1];
    cell.player.text = [[sectionStats objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.statVal.text = [NSString stringWithFormat:@"%@",[[sectionStats objectAtIndex:indexPath.row] objectAtIndex:1]];
    
    
    return cell;
}

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[self.sectionBools objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [self.sectionBools replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
