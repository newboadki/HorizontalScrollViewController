/*
     File: PhotoViewController.m
 Abstract: Configures and displays the paging scroll view and handles tiling and page configuration.
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "HorizontalScrollViewController.h"
#import "ScrollPageViewController.h"

@interface HorizontalScrollViewController()
- (void) createDataSource;
@end

@implementation HorizontalScrollViewController

#pragma mark -
#pragma mark View loading and unloading

- (void)loadView 
{    
    /***********************************************************************************************/
    /* Create and configure the scrolling view.                                                    */
	/***********************************************************************************************/
    // Create an instance of the data Source
    [self createDataSource];
    
    // Step 1: make the outer paging scroll view
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
    pagingScrollView.pagingEnabled = YES;
    pagingScrollView.backgroundColor = [UIColor blackColor];
    pagingScrollView.showsVerticalScrollIndicator = NO;
    pagingScrollView.showsHorizontalScrollIndicator = NO;
    pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
    pagingScrollView.delegate = self;
    self.view = pagingScrollView;
    
    // Step 2: prepare to tile content
    recycledPages = [[NSMutableSet alloc] init];
    visiblePages  = [[NSMutableSet alloc] init];
    NSLog(@"%d", recycledPages==nil);
    [self tilePages];
}


- (void) createDataSource
{
    dataSource = [[NSArray arrayWithObjects:@"UNO", @"DOS", @"TRES", @"CUATRO", nil] retain];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [pagingScrollView release];
    pagingScrollView = nil;
    [recycledPages release];
    recycledPages = nil;
    [visiblePages release];
    visiblePages = nil;
}


- (void)dealloc
{
    [pagingScrollView release];
    [dataSource release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Tiling and page configuration

- (void)tilePages 
{
    /***********************************************************************************************/
    /* tilePages                                                                                   */
	/***********************************************************************************************/
    // Calculate which pages are visible
    CGRect visibleBounds = pagingScrollView.bounds;
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [dataSource count] - 1);
        
    // Recycle no-longer-visible pages
    for (ScrollPageViewController* page in visiblePages)
    {        
        if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex)
        {
            [recycledPages addObject:page];
            [page.view removeFromSuperview];
        }
    }
    [visiblePages minusSet:recycledPages];
    
    // add missing pages
    for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++)
    {
        if (![self isDisplayingPageForIndex:index])
        {
            ScrollPageViewController* page = [self dequeueRecycledPage];
            if (page == nil)
            {
                page = [[[ScrollPageViewController alloc] init] autorelease];
            }
            
            [self configurePage:page forIndex:index];
            [pagingScrollView addSubview:page.view];
            [visiblePages addObject:page];
        }
    }    
}

- (ScrollPageViewController*) dequeueRecycledPage
{
    /***********************************************************************************************/
    /* We get any object from the recycledPages set, we remove from it, and return it.             */
	/***********************************************************************************************/
    ScrollPageViewController* page = [recycledPages anyObject];
    
    if (page) 
    {
        // the recycledPages set pressumably owns the last retain on the retrieved page.
        // thus they do this thing, so they can return it. Otherwise it would be removed from
        // memory before we can return it.
        [[page retain] autorelease];
        [recycledPages removeObject:page];
    }
    NSLog(@"is recycled and dequeued nil? %i", page==nil);
    return page;
}


- (BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
    /***********************************************************************************************/
    /* Returns true if there is a page in the visiblePages set with the sought index.              */
	/***********************************************************************************************/
    BOOL foundPage = NO;
    
    for (ScrollPageViewController* page in visiblePages)
    {
        if (page.index == index)
        {
            foundPage = YES;
            break;
        }
    }
    
    return foundPage;
}


- (void)configurePage:(ScrollPageViewController *)page forIndex:(NSUInteger)index
{
    /***********************************************************************************************/
    /* - Sets the page's index.                                                                    */
    /* - Sets the page's frame.                                                                    */
    /* - Displays the element in the page's view.                                                  */
	/***********************************************************************************************/    
    page.index = index;
    page.view.frame = [self frameForPageAtIndex:index];
    
    // Use tiled images
     [page displayViewWithElement:[dataSource objectAtIndex:page.index]];
}


#pragma mark -
#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tilePages];
}




#pragma mark -
#pragma mark View controller rotation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
{
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    /***********************************************************************************************/
    /* Here, our pagingScrollView bounds have not yet been updated for the new interface           */
    /* orientation. So this is a good place to calculate the content offset that we will need      */
    /* in the new orientation                                                                      */
	/***********************************************************************************************/
    // Content offset is the point in the content that is currently visible at the top left of the scroll's view bounds
    CGFloat offset = pagingScrollView.contentOffset.x;
    CGFloat pageWidth = pagingScrollView.bounds.size.width;

    if (offset >= 0)
    {        
        firstVisiblePageIndexBeforeRotation = floorf(offset / pageWidth);
        percentScrolledIntoFirstVisiblePage = (offset - (firstVisiblePageIndexBeforeRotation * pageWidth)) / pageWidth;        
    }
    else
    {
        firstVisiblePageIndexBeforeRotation = 0;
        percentScrolledIntoFirstVisiblePage = offset / pageWidth;
    }    
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    /***********************************************************************************************/
    /* willAnimateRotationToInterfaceOrientation.                                                  */
	/***********************************************************************************************/
    // Recalculate contentSize based on current orientation
    pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
    
    // Adjust frames and configuration of each visible page
    for (ScrollPageViewController* page in visiblePages)
    {
        CGPoint restorePoint = [page pointToCenterAfterRotation];
        CGFloat restoreScale = [page scaleToRestoreAfterRotation];
        page.view.frame = [self frameForPageAtIndex:page.index];
        [page restoreCenterPoint:restorePoint scale:restoreScale];        
    }
    
    // adjust contentOffset to preserve page location based on values collected prior to location
    CGFloat pageWidth = pagingScrollView.bounds.size.width;
    CGFloat newOffset = (firstVisiblePageIndexBeforeRotation * pageWidth) + (percentScrolledIntoFirstVisiblePage * pageWidth);
    pagingScrollView.contentOffset = CGPointMake(newOffset, 0);
}



#pragma mark -
#pragma mark Frame calculations
#define PADDING  0 // THE PADDING IS CAUSING THE FUCK-UP!!!!!

- (CGRect)frameForPagingScrollView
{
    /***********************************************************************************************/
    /* We calculate the frame of the paginScrollView. A page's frame is related to the scrollView  */
    /* that contains it.                                                                           */
	/* The page width is determined by the bounds width of the scroll view. Because of this, the   */
    /* only way we can implement the padding is by making the scrollingView bigger (it's frame).    */
	/***********************************************************************************************/								
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    
    return frame;
}


- (CGRect)frameForPageAtIndex:(NSUInteger)index
{
    /***********************************************************************************************/
    /* We have to use our paging scroll view's bounds, not frame, to calculate the page placement. */
    /* When the device is in landscape orientation, the frame will still be in portrait because the*/
    /* pagingScrollView is the root view controller's view, so its frame is in window coordinate   */
    /* space, which is never rotated. Its bounds, however, will be in landscape because it has a   */
    /* rotation transform applied.                                                                 */
	/***********************************************************************************************/								
    CGRect bounds = pagingScrollView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING); // The padding is added into the paginScrollViewBounds. So we substract it to calculate the width
    pageFrame.origin.x = (bounds.size.width * index) + PADDING; // keep the padding in mind to position the page's origin.x

    return pageFrame;
}


- (CGSize)contentSizeForPagingScrollView 
{
    /***********************************************************************************************/
    /* We have to use the paging scroll view's bounds to calculate the contentSize, for the same   */
    /* reason outlined above.                                                                      */
	/***********************************************************************************************/								
    CGRect bounds = pagingScrollView.bounds;
    CGSize contentSize = CGSizeMake(bounds.size.width * [dataSource count], bounds.size.height);
    
    return contentSize;
}





@end
