//
//  AUDLGameGraphViewController.m
//  AUDL
//
//  Created by Patrick on 1/15/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//


#import "AUDLGameGraphViewController.h"
#import "CorePlot-CocoaTouch.h"

@implementation AUDLGameGraphViewController

- (void)awakeFromNib
{
    // Initialization code
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //self.gameID.text = self.gID;
    
    [self gameDataRequest];
    
    if (([self.team1pnts count] < 2) && ([self.team2pnts count] < 2)) {
        self.noGraph.text = @"No graph available for this game.";
    }
    else{
        self.noGraph.text = @"";
        NSLog(self.team1);
        NSLog(self.team2);
        [self drawGraph];
    }
    
}

-(void)drawGraph {
    
    CGRect gFrame = self.view.bounds;
    //gFrame.size.height = 200;
    //gFrame.origin.y += 100;
    // We need a hostview, you can create one in IB (and create an outlet) or just do this:
    CPTGraphHostingView* hostView = [[CPTGraphHostingView alloc] initWithFrame:gFrame];
    [self.view addSubview: hostView];
    
    // Create a CPTGraph object and add to hostView
    CPTGraph* graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    graph.paddingLeft = 10.0;
    graph.paddingTop = 50.0;
    graph.paddingRight = 10.0;
    graph.paddingBottom = 50.0;
    hostView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 16 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -0.1 ) length:CPTDecimalFromFloat( 1 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot1 = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    plot1.identifier = @"Team1";
    CPTMutableLineStyle *ls = [CPTMutableLineStyle lineStyle];
    ls.lineWidth = 3.f;
    ls.lineColor = [CPTColor redColor];
    plot1.dataLineStyle = ls;
    
    CPTPlotSymbol *ps = [CPTPlotSymbol ellipsePlotSymbol];
    ps.size = CGSizeMake(10,10);
    ps.lineStyle = ls;
    plot1.plotSymbol = ps;
    
    
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot1.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [graph addPlot:plot1 toPlotSpace:graph.defaultPlotSpace];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot2 = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    plot2.identifier = @"Team2";
    ls.lineColor = [CPTColor blueColor];
    plot2.dataLineStyle = ls;
    ps.lineStyle = ls;
    plot2.plotSymbol = ps;
    
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot2.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [graph addPlot:plot2 toPlotSpace:graph.defaultPlotSpace];

    
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


// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    
    if ([plotnumberOfRecords.identifier isEqual:@"Team1"] == YES) {
        return [self.team1pnts count];
    }
    else
    {
        return [self.team2pnts count];
    }
    
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // We need to provide an X or Y (this method will be called for each) value for every index
    int x = index;
    //NSArray *teamPntsData = [[self.gameData objectAtIndex:0] objectAtIndex:1];
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    //NSArray *thisPntData = [teamPntsData objectAtIndex:index];
    //NSLog(@"%@",[thisPntData objectAtIndex:0]);
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        //NSLog(@"%@",self.gameData[0][0]);
        if ([plot.identifier isEqual:@"Team1"] == YES) {
            return [[self.team1pnts objectAtIndex:index] objectAtIndex:0];
        }
        else
        {
            return [[self.team2pnts objectAtIndex:index] objectAtIndex:0];
        }
    } else {
        // Return y value, forthis example we'll be plotting y = x * x
        if ([plot.identifier isEqual:@"Team1"] == YES) {
            return [[self.team1pnts objectAtIndex:index] objectAtIndex:1];
        }
        else
        {
            return [[self.team2pnts objectAtIndex:index] objectAtIndex:1];
        }
    }
}

- (void)gameDataRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Game/";
    path = [path stringByAppendingString:self.gID];
    path = [path stringByAppendingString:@"/graph"];
    NSString *full_url = [server_url stringByAppendingString: path];
    NSLog(full_url);
    NSURL * url = [[NSURL alloc] initWithString:full_url];
    
    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                //cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:30];
    
    // Prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    // Construct Array around the Data from the response
    NSArray *gameData = [NSJSONSerialization
                 JSONObjectWithData:urlData
                 options:0
                 error:&error];
    
    self.team1 = [[gameData objectAtIndex:0] objectAtIndex:0];
    self.team1pnts = [[gameData objectAtIndex:0] objectAtIndex:1];
    self.team2 = [[gameData objectAtIndex:1] objectAtIndex:0];
    self.team2pnts = [[gameData objectAtIndex:1] objectAtIndex:1];
    
}

@end
