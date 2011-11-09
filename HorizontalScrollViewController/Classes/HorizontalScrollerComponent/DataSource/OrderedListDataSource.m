//
//  OrderedListDataSource.m
//  FanApp
//
//  Created by Borja Arias Drake on 17/06/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "OrderedListDataSource.h"


@implementation OrderedListDataSource

@synthesize dataSourceDelegate;


#pragma mark - Initialisers

- (id) initWithDelegate:(id <OrderedListDataSourceDelegateProtocol>)theDelegate
{
    /***********************************************************************************************/
    /* init method.                                                                                */
    /***********************************************************************************************/
    if ((self = [super init]))
    {
        self->elementsArray = [[NSMutableArray alloc] init];
        [self setDataSourceDelegate:theDelegate];
    }
    
    return self;
}

// --------------------------------------------------------------------------------------------------



#pragma mark - Ordered List Data Source Methods

- (int) count
{
    /***********************************************************************************************/
    /* Returns the number of cached elements.                                                      */
    /***********************************************************************************************/
    return [self->elementsArray count];
}


- (id) elementAtIndex:(NSInteger)index
{
    /***********************************************************************************************/
    /* Returns the cached element at the passed index. Otherwise nil.                              */
    /***********************************************************************************************/
    if (index < 0 || index >= [self->elementsArray count])
    {
        return nil;
    }
    
    return [self->elementsArray objectAtIndex:index];
}


- (void) fetchElementsBatch:(int)amount beforeAndIncluding:(id)elementId
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/
    /***********************************************************************************************/
    @throw @"fetchElementBatch:beforeAndIncluding: must be implemented by subclasses.";
}


- (void) fetchElementsBatch:(int)amount afterAndIncluding:(id)elementId
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/    
    /***********************************************************************************************/
    @throw @"fetchElementBatch:afterAndIncluding: must be implemented by subclasses.";
}


- (void) fetchLatestElements:(int)amount
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/
    /* The latest element therefore will be inserted at the beginning of the array.                */
    /***********************************************************************************************/
    @throw @"fetchLatestElements: must be implemented by subclasses.";
}

// --------------------------------------------------------------------------------------------------



#pragma mark - Memory Management

- (void)dealloc
{
    /***********************************************************************************************/
    /* Tidy-up                                                                                     */
    /***********************************************************************************************/
    [self->elementsArray release];
    self->elementsArray = nil;    
    [self setDataSourceDelegate:nil];
    
    [super dealloc];
}

@end
