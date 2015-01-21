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
    
    // Get the gameData from the AUDL server
    [self gameDataRequest];
    
    //Set the view label according to graph data availability
    if (([self.team1pnts count] < 2) && ([self.team2pnts count] < 2)) {
        self.noGraph.text = @"No graph available for this game.";
    }
    else{
        self.noGraph.text = @"";
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    //load the graph if sufficient data is available
    if (([self.team1pnts count] > 2) && ([self.team2pnts count] > 2)) {
    
        [self drawGraph];

    }

    
}
-(void)drawGraph {
    
    
    CPTGraphHostingView* hostView = [[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: hostView];
    
    // Create a CPTGraph object and add to hostView
    CPTGraph* graph = [[CPTXYGraph alloc] init];
    graph.paddingLeft = 15.0;
    graph.paddingTop = 80.0;
    graph.paddingRight = 20.0;
    graph.paddingBottom = 50.0;
    hostView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    float ymax = ([self.team1pnts count ] > [self.team2pnts count]) ?
        (float)[self.team1pnts count] : (float)[self.team2pnts count];
    //Setup plot maxes/mins
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -0.15 ) length:CPTDecimalFromFloat( ymax )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -0.15 ) length:CPTDecimalFromFloat( 1.25 )]];
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END)
    
    //Setup axis tic formatting
    CPTXYAxisSet *axSet = (CPTXYAxisSet*) graph.axisSet;
    
    CPTXYAxis *x = axSet.xAxis;
    x.majorIntervalLength = CPTDecimalFromFloat(1);
    x.minorTicksPerInterval = 1;
    x.borderWidth = 0;
    
    CPTXYAxis *y = axSet.yAxis;
    y.majorIntervalLength = CPTDecimalFromFloat(5);
    y.minorTicksPerInterval = 5;
    //.y.borderWidth = 0;
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot1 = [[CPTScatterPlot alloc] initWithFrame:self.view.bounds];
    plot1.identifier = @"Team1";
    // set plot title to the first team name
    plot1.title = self.team1;
    // setup the linestyle with a red color for the first team
    CPTMutableLineStyle *ls = [CPTMutableLineStyle lineStyle];
    ls.lineWidth = 2.f;
    ls.lineColor = [CPTColor redColor];
    plot1.dataLineStyle = ls;
    
    // setup markers for the plot (red for the first team)
    CPTPlotSymbol *ps = [CPTPlotSymbol ellipsePlotSymbol];
    ps.size = CGSizeMake(5,5);
    ps.lineStyle = ls;
    ps.fill = [CPTFill fillWithColor:[CPTColor redColor]];
    plot1.plotSymbol = ps;
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot1.dataSource = self;
    
    // add the first plot to our graph view
    [graph addPlot:plot1 toPlotSpace:graph.defaultPlotSpace];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    
    CPTScatterPlot* plot2 = [[CPTScatterPlot alloc] initWithFrame:self.view.bounds];
    plot2.identifier = @"Team2";
    // set the second team name to the plot title
    plot2.title = self.team2;
    //change line color to blue for the second team
    ls.lineColor = [CPTColor blueColor];
    plot2.dataLineStyle = ls;
    ps.lineStyle = ls;
    // set the markers to blue for the second team
    ps.fill = [CPTFill fillWithColor:[CPTColor blueColor]];
    plot2.plotSymbol = ps;
    
    // add this view controller as the data source for the plot
    plot2.dataSource = self;
    
    // now add the plot for the second team to this graph view
    [graph addPlot:plot2 toPlotSpace:graph.defaultPlotSpace];

    //setup the legend for the graph
    graph.legend = [CPTLegend legendWithGraph:graph];
    graph.legend.fill = [CPTFill fillWithColor:[CPTColor whiteColor] ];
    graph.legend.cornerRadius = 5;
    graph.legendDisplacement = CGPointMake(0, 4.0);

    
}

- (id)initWithGameID:(NSString *) ID
{
    self = [super init];
    // set the graphView's game id value
    if (self) {
        self.gID = ID;
    }
    return self;
}


// The following methods are here because this class also functions as datasource for our graph
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


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    //For x values
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // If this is the first team's plot return its data
        if ([plot.identifier isEqual:@"Team1"] == YES) {
            return [[self.team1pnts objectAtIndex:index] objectAtIndex:0];
        }
        // If this is the second team return its data
        else
        {
            return [[self.team2pnts objectAtIndex:index] objectAtIndex:0];
        }
        
    //For y values
    } else {
        
        // If this is the first team's plot return its data
        if ([plot.identifier isEqual:@"Team1"] == YES) {
            return [[self.team1pnts objectAtIndex:index] objectAtIndex:1];
        }
        // If this is the second team return its data
        else
        {
            return [[self.team2pnts objectAtIndex:index] objectAtIndex:1];
        }
        
    }
}

// Function for getting all available game graph data from the AUDL server
- (void)gameDataRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Game/";
    path = [path stringByAppendingString:self.gID];
    path = [path stringByAppendingString:@"/graph"];
    NSString *full_url = [server_url stringByAppendingString: path];

    NSURL *url = [[NSURL alloc] initWithString:full_url];
    
    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                cachePolicy:
                                NSURLRequestReloadIgnoringLocalCacheData
                                timeoutInterval: 30];
    
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
    
    // divy up the data to the appropriate class properties
    self.team1 = [[gameData objectAtIndex:0] objectAtIndex:0];
    self.team1pnts = [[gameData objectAtIndex:0] objectAtIndex:1];
    self.team2 = [[gameData objectAtIndex:1] objectAtIndex:0];
    self.team2pnts = [[gameData objectAtIndex:1] objectAtIndex:1];
    
}

@end
