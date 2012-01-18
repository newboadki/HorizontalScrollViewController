#import "Kiwi.h"
#import "PageController.h"
#import "CustomViewControllerProtocol.h"
#import "HorizontalScrollViewController.h"
#import "PageController.h"
#import "LoadingScreenViewController.h"
#import "OrderedListDataSource.h"
#import "PurplePageController.h"

SPEC_BEGIN(HorizontalScrollViewControllerSpec)

describe(@"dequeScrollPageToBeVisibleWithIndex", ^{

    __block HorizontalScrollViewController* controller;
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
        NSMutableSet* visiblePages = [[NSMutableSet alloc] init];
        [controller setValue:visiblePages forKey:@"visiblePages"];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];
        [visiblePages release];
    });
    
    afterEach(^{
        [controller release];
    });
        
    it(@"should create a page", ^{
        controller.pageControllerClass = [PurplePageController class];
        NSMutableSet* visiblePages = [controller valueForKey:@"visiblePages"];
        STAssertTrue([visiblePages count] == 0, @"");
        [controller dequeScrollPageToBeVisibleWithIndex:0];
        STAssertTrue([visiblePages count] == 1, @"");
    });

    it(@"should configure the page", ^{
        PageController* page = [[PageController alloc] init];
        [controller stub:@selector(dequeueRecycledPage) andReturn:page];
        [[controller should] receive:@selector(configurePage:forIndex:) withArguments:page, theValue(1)];
        
        [controller dequeScrollPageToBeVisibleWithIndex:1];
        [page release];
    });
        
    it(@"should send the message viewWillAppear the page controller", ^{
        PageController* page = [[PageController alloc] init];
        [controller stub:@selector(dequeueRecycledPage) andReturn:page];
        [[page should] receive:@selector(viewWillAppear:) withArguments:theValue(YES)];
        
        [controller dequeScrollPageToBeVisibleWithIndex:1];
        [page release];
    });

    it(@"should send the message viewDidAppear to the page controller", ^{
        PageController* page = [[PageController alloc] init];
        [controller stub:@selector(dequeueRecycledPage) andReturn:page];
        [[page should] receive:@selector(viewDidAppear:) withArguments:theValue(YES)];
        
        [controller dequeScrollPageToBeVisibleWithIndex:1];
        [page release];
    });
    
    it(@"should add the page to the visiblePages set", ^{
        id scrollViewMock = [KWMock nullMockForClass:[UIScrollView class]];
        [controller setValue:scrollViewMock forKey:@"pagingScrollView"];
        PageController* page = [[PageController alloc] init];
        [controller stub:@selector(dequeueRecycledPage) andReturn:page];
        [[scrollViewMock should] receive:@selector(addSubview:) withArguments:page.view];
        
        [controller dequeScrollPageToBeVisibleWithIndex:1];
        [page release];
    });    
});

describe(@"recycleNoLongerUsedPagesWithfirstNeededPage", ^{

    __block HorizontalScrollViewController* controller;
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
        NSMutableSet* visiblePages = [[NSMutableSet alloc] init];
        [controller setValue:visiblePages forKey:@"visiblePages"];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

        [visiblePages release];
    });
    
    afterEach(^{
        [controller release];
    });

    it(@"should send the messages view Will and Did disappear", ^{
        UIScrollView* pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        NSArray* dataSource = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", nil];
        PageController* page = [[PageController alloc] init];
        page.index = 1;
        NSMutableSet* recycledPages = [[NSMutableSet alloc] init];
        NSMutableSet* visiblePages = [[NSMutableSet alloc] init];
        [visiblePages addObject:page];
        
        [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
        [controller setValue:dataSource forKey:@"dataSource"];
        [controller setValue:visiblePages forKey:@"visiblePages"];
        [controller setValue:recycledPages forKey:@"recycledPages"];
        
        [[page should] receive:@selector(viewWillDisappear:) withArguments:theValue(YES)];
        [[page should] receive:@selector(viewDidDisappear:) withArguments:theValue(YES)];
        
        [controller recycleNoLongerUsedPagesWithfirstNeededPage:2 lastNeededPage:3];
        
        
        [pagingScrollView release];
        [page release];
        
        [visiblePages release];
        [recycledPages release];        
    });
});

describe(@"addLoadingPageToVisiblePagesAtIndex", ^{
    
    __block HorizontalScrollViewController* controller;
    __block LoadingScreenViewController* loadingPageMock;
    __block UIScrollView* pagingScrollViewMock;
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
        loadingPageMock = [KWMock nullMockForClass:[LoadingScreenViewController class]];
        UIView* loadingViewMock = [KWMock nullMockForClass:[UIView class]];
        pagingScrollViewMock = [KWMock nullMockForClass:[UIScrollView class]];
        
        [loadingPageMock stub:@selector(view) andReturn:loadingViewMock];
        [controller setValue:loadingPageMock forKey:@"loadingController"];
        [controller setValue:pagingScrollViewMock forKey:@"pagingScrollView"];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

    });
    
    afterEach(^{
        [controller release];
    });
    
    it(@"should send the messages view Will and Did appear", ^{
        OrderedListDataSource* dataSource = [KWMock nullMockForClass:[OrderedListDataSource class]];

        NSMutableSet* recycledPages = [KWMock nullMockForClass:[NSMutableSet class]];
        NSMutableSet* visiblePages = [KWMock nullMockForClass:[NSMutableSet class]];
        [controller setValue:pagingScrollViewMock forKey:@"pagingScrollView"];
        [controller setValue:dataSource forKey:@"dataSource"];
        [controller setValue:visiblePages forKey:@"visiblePages"];
        [controller setValue:recycledPages forKey:@"recycledPages"];
        
        [[loadingPageMock should] receive:@selector(viewWillAppear:) withArguments:theValue(YES)];
        [[loadingPageMock should] receive:@selector(viewDidAppear:) withArguments:theValue(YES)];
        [controller addLoadingPageToVisiblePagesAtIndex:2];
    });
    
    it(@"should configure the page for the given index", ^{
        [[controller should] receive:@selector(configurePage:forIndex:) withArguments:loadingPageMock, theValue(0)];
        
        [controller addLoadingPageToVisiblePagesAtIndex:0];
    });
    
    it(@"should add the loading page view to the hierarchy", ^{
        [[pagingScrollViewMock should] receive:@selector(addSubview:) withArguments:loadingPageMock.view];
        [controller addLoadingPageToVisiblePagesAtIndex:0];        
    });
    
    it(@"should not add the page to the visiblePages set", ^{
        NSMutableSet* visiblePagesMock = [[[NSMutableSet alloc] init] autorelease];
        [controller setValue:visiblePagesMock forKey:@"visiblePages"];
        [controller addLoadingPageToVisiblePagesAtIndex:0];
        STAssertTrue([visiblePagesMock count] == 0, @"");
    });
});

describe(@"pageControllerClass property", ^{
    it(@"should have a property called pageControllerClass", ^{
        HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
        controller.pageControllerClass = [PageController class];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

        STAssertTrue(controller.pageControllerClass == [PageController class], @"");
        
    });
});

describe(@"loadingPageControllerName", ^{
    
    it(@"should return a default name if the property loadingPageControllerClass has not been set", ^{
        HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

        controller.loadingPageControllerClass = NULL;
        
        STAssertTrue([controller safeLoadingPageControllerClass] == [LoadingScreenViewController class], @"");
    });

    it(@"should return the value of the property loadingPageControllerClass if it's been set", ^{
        HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

        controller.loadingPageControllerClass = [PageController class];
        
        STAssertTrue([controller safeLoadingPageControllerClass] == [PageController class], @"");;
    });

});

describe(@"loadView", ^{
    
    it(@"should send the message 'safeLoadingPageControllerClass'", ^{
        HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

        [[controller should] receive:@selector(safeLoadingPageControllerClass)];
        [controller loadView];
    });
    
});

describe(@"makeMissingPagesVisibleWithfirstNeededPage", ^{

    __block HorizontalScrollViewController* controller;
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];

    });
    
    afterEach(^{
        [controller release];   
    });
    
    context(@"when the page is already been displayed", ^{
        
        beforeEach(^{
            NSMutableSet* visiblePages = [[[NSMutableSet alloc] init] autorelease];            
            PageController* pageMock1 = [KWMock nullMockForClass:[PageController class]];
            PageController* pageMock2 = [KWMock nullMockForClass:[PageController class]];
            [pageMock1 stub:@selector(index) andReturn:theValue(0)];
            [pageMock1 stub:@selector(index) andReturn:theValue(1)];
            [visiblePages addObject:pageMock1];
            [visiblePages addObject:pageMock2];            
            
            [controller setValue:visiblePages forKey:@"visiblePages"];                        
        });
                
        it(@"should not show the loading page", ^{            
            [[controller shouldNot] receive:@selector(addLoadingPageViewToHierarchyForIndex:)];
            [controller makeMissingPagesVisibleWithfirstNeededPage:0 lastNeededPage:1];
        });
                
        it(@"should not dequeue the loading page", ^{
            [[controller shouldNot] receive:@selector(dequeScrollPageToBeVisibleWithIndex:)];
            [controller makeMissingPagesVisibleWithfirstNeededPage:0 lastNeededPage:1];
        });
    });
    
    context(@"when the page is not been displayed", ^{

        beforeEach(^{
            NSMutableSet* visiblePages = [[[NSMutableSet alloc] init] autorelease];            
            [controller setValue:visiblePages forKey:@"visiblePages"];
        });

        it(@"should show the loading page if the index is 0", ^{
            [[controller should] receive:@selector(addLoadingPageViewToHierarchyForIndex:) withArguments:theValue(0)];
            [controller makeMissingPagesVisibleWithfirstNeededPage:0 lastNeededPage:0];
        });
        
        it(@"should show the loading page if the index is N+1", ^{
            OrderedListDataSource* dataSourceMock = [KWMock mockForClass:[OrderedListDataSource class]];
            [dataSourceMock stub:@selector(count) andReturn:theValue(5)];
            [controller setDataSource:dataSourceMock];
            [[controller should] receive:@selector(addLoadingPageViewToHierarchyForIndex:) withArguments:theValue(6)];
            [controller makeMissingPagesVisibleWithfirstNeededPage:6 lastNeededPage:6];
        });
        
        it(@"should dequeue a content page if the the index is between 0 and N+1", ^{
            OrderedListDataSource* dataSourceMock = [KWMock mockForClass:[OrderedListDataSource class]];
            [dataSourceMock stub:@selector(count) andReturn:theValue(1)];
            [controller setDataSource:dataSourceMock];
            [[controller should] receive:@selector(dequeScrollPageToBeVisibleWithIndex:) withArguments:theValue(1)];
            [controller makeMissingPagesVisibleWithfirstNeededPage:1 lastNeededPage:1];
        });
    });
    
});

describe(@"configurePage:forIndex", ^{

    __block HorizontalScrollViewController* controller;
    __block UIScrollView* pagingScrollViewMock;
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];
        
        pagingScrollViewMock = [KWMock nullMockForClass:[UIScrollView class]];        
        OrderedListDataSource* dataSourceMock = [KWMock mockForClass:[OrderedListDataSource class]];
        [dataSourceMock stub:@selector(count) andReturn:theValue(4)];
        
        [controller setValue:pagingScrollViewMock forKey:@"pagingScrollView"];
        [controller setDataSource:dataSourceMock];
        
    });
    
    afterEach(^{
        [controller release];
    });

    it(@"should call displayViewWithElement: if the index is within the interval. First valid index", ^{
        
        id elementMock = [KWMock nullMock];
        PageController* pageMock = [KWMock nullMockForClass:[PageController class]];
        [pageMock stub:@selector(index) andReturn:theValue(1)];
        [controller.dataSource stub:@selector(elementAtIndex:) andReturn:elementMock withArguments:theValue(0)];
        [[pageMock should] receive:@selector(displayViewWithElement:) withArguments:elementMock];
        [controller configurePage:pageMock forIndex:1];
    });
    
    it(@"should call displayViewWithElement: if the index is within the interval. last valid index", ^{
        id elementMock = [KWMock nullMock];
        PageController* pageMock = [KWMock nullMockForClass:[PageController class]];
        [pageMock stub:@selector(index) andReturn:theValue(4)];
        [controller.dataSource stub:@selector(elementAtIndex:) andReturn:elementMock withArguments:theValue(3)];
        [[pageMock should] receive:@selector(displayViewWithElement:) withArguments:elementMock];
        [controller configurePage:pageMock forIndex:4];
    });
    
    it(@"should call displayViewWithElement: if the index is within the interval. number in the middle index", ^{
        id elementMock = [KWMock nullMock];
        PageController* pageMock = [KWMock nullMockForClass:[PageController class]];
        [pageMock stub:@selector(index) andReturn:theValue(2)];
        [controller.dataSource stub:@selector(elementAtIndex:) andReturn:elementMock withArguments:theValue(1)];
        [[pageMock should] receive:@selector(displayViewWithElement:) withArguments:elementMock];
        [controller configurePage:pageMock forIndex:2];
    });

    
    it(@"should not call displayViewWithElement: if the index is not within the interval. under the limit", ^{
        id elementMock = [KWMock nullMock];
        PageController* pageMock = [KWMock nullMockForClass:[PageController class]];
        [[pageMock shouldNot] receive:@selector(displayViewWithElement:)];
        [controller configurePage:pageMock forIndex:0];
    });

    it(@"should not call displayViewWithElement: if the index is not within the interval. over the limit", ^{
        id elementMock = [KWMock nullMock];
        PageController* pageMock = [KWMock nullMockForClass:[PageController class]];
        [[pageMock shouldNot] receive:@selector(displayViewWithElement:)];
        [controller configurePage:pageMock forIndex:5];
    });
    
});

describe(@"ScrollViewDidEndDecelerating:", ^{

    __block HorizontalScrollViewController* controller;
    __block UIScrollView* pagingScrollViewMock;
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
        [controller setLoadingPageNibName:@"LoadingScreenViewController"];
        [controller setContentPageNibName:@"SamplePage"];
        
        pagingScrollViewMock = [KWMock nullMockForClass:[UIScrollView class]];        
        CGRect scrollViewBrounds = CGRectMake(0, 0, 320, 480);
        [pagingScrollViewMock stub:@selector(bounds) andReturn:theValue(scrollViewBrounds)];

        OrderedListDataSource* dataSourceMock = [KWMock mockForClass:[OrderedListDataSource class]];
        [dataSourceMock stub:@selector(count) andReturn:theValue(4)];
        
        [controller setValue:pagingScrollViewMock forKey:@"pagingScrollView"];
        [controller setDataSource:dataSourceMock];        
    });
    
    afterEach(^{
        [controller release];
    });

    
    it(@"should add the loading page to the hierarchy if current index is 0", ^{        
        OrderedListDataSource* dataSourceMock = [KWMock nullMockForClass:[OrderedListDataSource class]];// null so it doesn't get an unexpected message for fetching                
        [dataSourceMock stub:@selector(count) andReturn:theValue(4)]; // but we still need a count to the comparason gets in the right clause
        [controller setDataSource:dataSourceMock];        

        CGPoint scrollViewOffset = CGPointMake(0.0, 0.0);
        [pagingScrollViewMock stub:@selector(contentOffset) andReturn:theValue(scrollViewOffset)];
        [[controller should] receive:@selector(addLoadingPageToVisiblePagesAtIndex:) withArguments:theValue(0)];
        [controller scrollViewDidEndDecelerating:pagingScrollViewMock];
    });

    it(@"should fetch more elements before from the datasource if index is 0", ^{        
        CGPoint scrollViewOffset = CGPointMake(300.0, 0.0);
        [pagingScrollViewMock stub:@selector(contentOffset) andReturn:theValue(scrollViewOffset)];
        [[controller.dataSource should] receive:@selector(fetchElementsBatch:beforeAndIncluding:)];
        [[controller.dataSource shouldNot] receive:@selector(fetchElementsBatch:afterAndIncluding:)];

        [controller scrollViewDidEndDecelerating:pagingScrollViewMock];
    });

    
    it(@"should add the loading page to the hierarchy if current index is N+1", ^{        
        OrderedListDataSource* dataSourceMock = [KWMock nullMockForClass:[OrderedListDataSource class]]; // null so it doesn't get an unexpected message for fetching        
        [dataSourceMock stub:@selector(count) andReturn:theValue(4)]; // but we still need a count to the comparason gets in the right clause
        [controller setDataSource:dataSourceMock];        
        CGPoint scrollViewOffset = CGPointMake(1700.0, 0.0);
        [pagingScrollViewMock stub:@selector(contentOffset) andReturn:theValue(scrollViewOffset)];
        [[controller should] receive:@selector(addLoadingPageToVisiblePagesAtIndex:) withArguments:theValue(5)];
        [controller scrollViewDidEndDecelerating:pagingScrollViewMock];
    });

    it(@"should fetch more elements before from the datasource if index is N+1", ^{        
        CGPoint scrollViewOffset = CGPointMake(1700, 0.0);
        [pagingScrollViewMock stub:@selector(contentOffset) andReturn:theValue(scrollViewOffset)];
        [[controller.dataSource should] receive:@selector(fetchElementsBatch:afterAndIncluding:)];
        [[controller.dataSource shouldNot] receive:@selector(fetchElementsBatch:beforeAndIncluding:)];

        [controller scrollViewDidEndDecelerating:pagingScrollViewMock];
    });

    it(@"should not add the loading page to the hierarchy if current index is > 0", ^{        
        
        CGPoint scrollViewOffset = CGPointMake(500, 0.0);
        [pagingScrollViewMock stub:@selector(contentOffset) andReturn:theValue(scrollViewOffset)];
        [[controller shouldNot] receive:@selector(addLoadingPageToVisiblePagesAtIndex:)];
        [controller scrollViewDidEndDecelerating:pagingScrollViewMock];
    });

    it(@"should not add the loading page to the hierarchy if current index is < N+1", ^{        
        
        CGPoint scrollViewOffset = CGPointMake(1000, 0.0);
        [pagingScrollViewMock stub:@selector(contentOffset) andReturn:theValue(scrollViewOffset)];
        [[controller shouldNot] receive:@selector(addLoadingPageToVisiblePagesAtIndex:)];
        [controller scrollViewDidEndDecelerating:pagingScrollViewMock];
    });
    
});

SPEC_END