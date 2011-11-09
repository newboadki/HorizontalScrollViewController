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
    
    beforeEach(^{
        controller = [[HorizontalScrollViewController alloc] init];
    });
    
    afterEach(^{
        [controller release];
    });
    
    it(@"should send the messages view Will and Did appear", ^{
        UIScrollView* pagingScrollView = [KWMock nullMockForClass:[UIScrollView class]];
        OrderedListDataSource* dataSource = [KWMock nullMockForClass:[OrderedListDataSource class]];
        LoadingScreenViewController* pageMock = [KWMock nullMockForClass:[LoadingScreenViewController class]];

        NSMutableSet* recycledPages = [KWMock nullMockForClass:[NSMutableSet class]];
        NSMutableSet* visiblePages = [KWMock nullMockForClass:[NSMutableSet class]];
        [controller setValue:pagingScrollView forKey:@"pagingScrollView"];
        [controller setValue:dataSource forKey:@"dataSource"];
        [controller setValue:visiblePages forKey:@"visiblePages"];
        [controller setValue:recycledPages forKey:@"recycledPages"];
        [controller setValue:pageMock forKey:@"loadingController"];
        
        [[pageMock should] receive:@selector(viewWillAppear:) withArguments:theValue(YES)];
        [[pageMock should] receive:@selector(viewDidAppear:) withArguments:theValue(YES)];
        [controller addLoadingPageToVisiblePagesAtIndex:2];
    });
});


describe(@"pageControllerClass property", ^{
    it(@"should have a property called pageControllerClass", ^{
        HorizontalScrollViewController* controller = [[HorizontalScrollViewController alloc] init];
        controller.pageControllerClass = [PageController class];
        STAssertTrue(controller.pageControllerClass == [PageController class], @"");
    });
});

SPEC_END