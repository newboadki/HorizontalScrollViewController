//
//  HorizontalScrollViewControllerTests.m
//  HorizontalScrollViewControllerTests
//
//  Created by Borja Arias Drake on 14/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "HorizontalScrollViewControllerTests.h"
#import <objc/runtime.h>
#import "OCMock.h"
#import "PageController.h"
#import "MainScreenMock.h"
#import "OrderedListDataSource.h"
#import "Kiwi.h"

@implementation HorizontalScrollViewControllerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testLoadView
{
    OrderedListDataSource* dataSourceMock = [KWMock mockForClass:[OrderedListDataSource class]];
    [dataSourceMock stub:@selector(count) andReturn:theValue(4)];
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    controller.dataSource = dataSourceMock;
    [controller loadView];
    
    UIScrollView* scrollingView = [controller valueForKey:@"pagingScrollView"];
    
    STAssertNotNil(scrollingView, @"loadView method should set the scrolling view");
    STAssertTrue(scrollingView.pagingEnabled == YES, @"the pagingScrollView should have paging enabled");
    STAssertTrue([[scrollingView.backgroundColor description] isEqualToString:@"UIDeviceWhiteColorSpace 0 1"]  , @"the pagingScrollView should have a black background color. %@", [scrollingView.backgroundColor description]);
    STAssertTrue(scrollingView.showsVerticalScrollIndicator == NO, @"the pagingScrollView should have showsVerticalScrollIndicator disabled");
    STAssertTrue(scrollingView.bounces == NO, @"the pagingScrollView bounces property should be set to NO");
    STAssertTrue(scrollingView.showsHorizontalScrollIndicator == NO, @"the pagingScrollView should have showsHorizontalScrollIndicator disabled");
    STAssertTrue(scrollingView.delegate == controller, @"the pagingScrollView's delegate should be the contorller.");
    STAssertTrue(scrollingView.contentSize.width == 1920, @"the pagingScrollView contentSize should adjust depending on the datasource count + 2 pages for loading. Found %f",scrollingView.contentSize.width );
    STAssertTrue(scrollingView.contentSize.height == 480, @"the pagingScrollView contentSize should adjust depending on the datasource count");
    STAssertTrue(controller.view == scrollingView, @"The controllers view should be the pageScrollingView");
    NSMutableSet* recycled=nil;
    NSMutableSet* visible=nil;
    object_getInstanceVariable(controller, "recycledPages", &recycled);
    object_getInstanceVariable(controller, "visiblePages", &visible);
    STAssertNotNil(recycled, @"the init method should set recycledPages");
    STAssertNotNil(visible, @"the init method should set visiblePages");
    
    [controller release];
}


/*- (void) testTildePages
 {
 id pageScrollViewMock = [OCMockObject mockForClass:[UIScrollView class]];
 CGRect bounds = CGRectMake(0.0, 0.0, 320.0, 480.0);
 NSValue* boundsValue = [NSValue valueWithCGRect:bounds];
 
 // [[[pageScrollViewMock stub] bounds] andReturnValue:boundsValue]; // THIS IS A PROBLEM, bounds returns a struct, and we need to call andReturnValue on a stuct...it won't work
 HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
 [controller setValue:pageScrollViewMock forKey:@"pagingScrollView"];
 
 
 [controller release];
 }*/

- (void) testDequeueRecycledPages
{
    id pageMock = [OCMockObject mockForClass:[PageController class]];
    NSMutableSet* recycledPages = [[NSMutableSet alloc] init];
    [recycledPages addObject:pageMock];
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    [controller setValue:recycledPages forKey:@"recycledPages"];
    PageController* dequeuedPage = [controller dequeueRecycledPage];    
    STAssertNotNil(dequeuedPage, @"dequeueRecycledPage should return an object if it contains one");
    dequeuedPage = [controller dequeueRecycledPage];    
    STAssertNil(dequeuedPage, @"dequeueRecycledPage should return nil when there aren't more queued pages");
    
    [pageMock verify];
    [controller release];
    [recycledPages release];
}


- (void) testIsDisplayingPageForIndex
{
    NSMutableSet* visiblePages = [[NSMutableSet alloc] init];
    PageController* page1 = [[PageController alloc] init];
    PageController* page2 = [[PageController alloc] init];
    page1.index = 0;    
    page2.index = 1;
    [visiblePages addObject:page1];
    [visiblePages addObject:page2];
    
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setValue:visiblePages forKey:@"visiblePages"];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    STAssertTrue([controller isDisplayingPageForIndex:0] == YES, @"isDisplayingPAgeFor index should return true for a visible page");
    STAssertTrue([controller isDisplayingPageForIndex:1] == YES, @"isDisplayingPAgeFor index should return true for a visible page");
    STAssertTrue([controller isDisplayingPageForIndex:2] == NO, @"isDisplayingPAgeFor index should return false for a visible page");
    
    [controller release];
    [visiblePages release];   
    [page1 release];
    [page2 release];
}

/*
 - (void)configurePage:(ScrollPageViewController *)page forIndex:(NSUInteger)index
 {
 page.index = index;
 page.view.frame = [self frameForPageAtIndex:index];
 
 // Use tiled images
 [page displayViewWithElement:[dataSource objectAtIndex:page.index]];
 }
 
 */

- (void) testConfigurePageSetsTheFrame
{
    
    PageController* page = [[PageController alloc] init];
    UIScrollView* pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
    [controller configurePage:page forIndex:1];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    
    CGRect frame = page.view.frame;
    
    STAssertTrue(frame.origin.x == 320.0, @"configure page should set frame x to 320. Found %f", frame.origin.x);
    STAssertTrue(frame.origin.y == 0.0, @"configure page should set frame y to 0. Found %f", frame.origin.y);
    STAssertTrue(frame.size.width == 320.0, @"configure page should set frame width to 320. Found %f", frame.size.width);
    STAssertTrue(frame.size.height == 480, @"configure page should set frame height to 480. Found %f", frame.size.height);
    STAssertTrue(page.index == 1, @"configure page should set the index of the page");
    
    [controller release];
    [page release];
}




- (void) testWillRotateToInterfaceOrientation
{
    UIScrollView* pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    CGPoint offset = CGPointMake(320.0, 0.0);
    pagingScrollView.contentOffset = offset;
    
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    
    [controller willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1.0];
    float firstVisiblePage = [(NSNumber*)[controller valueForKey:@"firstVisiblePageIndexBeforeRotation"] floatValue];
    float percentScrolledIntoFirstVisiblePage = [(NSNumber*)[controller valueForKey:@"percentScrolledIntoFirstVisiblePage"] floatValue];
    
    STAssertTrue(firstVisiblePage == 1.0, @"willRotateToInterfaceOrientation should calculate the firstVisiblePage when offset >=0");
    STAssertTrue(percentScrolledIntoFirstVisiblePage == 0.0, @"willRotateToInterfaceOrientation should calculate the percentScrolledIntoFirstVisiblePAge when offset >=0");
    
    offset = CGPointMake(-320.0, 0.0);
    pagingScrollView.contentOffset = offset;
    [controller setValue:pagingScrollView forKey:@"pagingScrollView"];    
    [controller willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1.0];
    firstVisiblePage = [(NSNumber*)[controller valueForKey:@"firstVisiblePageIndexBeforeRotation"] floatValue];
    percentScrolledIntoFirstVisiblePage = [(NSNumber*)[controller valueForKey:@"percentScrolledIntoFirstVisiblePage"] floatValue];
    
    
    STAssertTrue(firstVisiblePage == 0.0, @"willRotateToInterfaceOrientation should set the firstVisiblePage to 0 when offset <0");
    STAssertTrue(percentScrolledIntoFirstVisiblePage == -1.0, @"willRotateToInterfaceOrientation should calculate the percentScrolledIntoFirstVisiblePAge when offset <0");
    
    
    [pagingScrollView release];
    [controller release];
}


- (void) testFrameForPagingScrollView
{
    // assuming PADDING is 0
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    Swizzle([UIScreen class], @selector(mainScreen), [HorizontalScrollViewControllerTests class], @selector(mainScreenStub));
    CGRect frame = [controller frameForPagingScrollView];
    STAssertTrue(frame.origin.x == 0, @"The origin x should be 0. Found %f", frame.origin.x);
    STAssertTrue(frame.size.width == 320.0, @"The origin x should be 0. Found %f", frame.size.width);
    [controller release];
    
}


- (void) testFrameForPageAtIndex
{
    UIScrollView* pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];

    [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
    
    CGRect frame = [controller frameForPageAtIndex:3];
    
    STAssertTrue(frame.origin.x == 960.0, @"Frame origin x should be %f. Found %f", 960.0,  frame.origin.x);
    STAssertTrue(frame.origin.y == 0.0, @"Frame origin y should be %f. Found %f", 0.0,  frame.origin.y);
    STAssertTrue(frame.size.width == 320.0, @"Frame size width should be %f. Found %f", 320.0,  frame.size.width);
    STAssertTrue(frame.size.height == 480.0, @"Frame size height should be %f. Found %f", 480.0,  frame.size.height);
    
    [pagingScrollView release];
    [controller release];
}


- (void) testContentSizeForPaginScrollView
{
    UIScrollView* pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    NSArray* dataSource = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", nil];    
    
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];
    [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
    [controller setValue:dataSource forKey:@"dataSource"];
    
    CGSize contentSize = [controller contentSizeForPagingScrollView];
    
    STAssertTrue(contentSize.width == 1920.0, @"contentSize width should be %f. Found %f", 1920.0,  contentSize.width);
    STAssertTrue(contentSize.height == 480.0, @"contentSize height should be %f. Found %f", 480.0,  contentSize.height);
    
    [pagingScrollView release];
    [controller release];
}


- (MainScreenMock*) mainScreenStub
{
    return [[[MainScreenMock alloc] init] autorelease];
}


- (void) testRecycleNoLongerUsedPagesWithfirstNeededPage
{
    UIScrollView* pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    NSArray* dataSource = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", nil];
    PageController* page = [[PageController alloc] init];
    page.index = 1;
    NSMutableSet* recycledPages = [[NSMutableSet alloc] init];
    NSMutableSet* visiblePages = [[NSMutableSet alloc] init];
    [visiblePages addObject:page];
    HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
    
    [controller setLoadingPageNibName:@"LoadingScreenViewController"];
    [controller setContentPageNibName:@"SamplePage"];
    [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
    [controller setValue:dataSource forKey:@"dataSource"];
    [controller setValue:visiblePages forKey:@"visiblePages"];
    [controller setValue:recycledPages forKey:@"recycledPages"];
    
    [controller recycleNoLongerUsedPagesWithfirstNeededPage:2 lastNeededPage:3];
    STAssertTrue([recycledPages count] == 1, @"The page should have been added to recycledPages. Count was %d", [recycledPages count]);
    STAssertNil(page.view.superview, @"the page's superview should be nil after the method call");
    [pagingScrollView release];
    [page release];
    [controller release];
    [visiblePages release];
    [recycledPages release];
}


@end
