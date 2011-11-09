//
//  TextnumbersDataSource.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias on 08/11/2011.
//  Copyright (c) 2011 Unboxed Consulting. All rights reserved.
//

#import "TextnumbersDataSource.h"


@implementation TextnumbersDataSource


- (id) initWithDelegate:(id <OrderedListDataSourceDelegateProtocol>)theDelegate
{
    /***********************************************************************************************/
    /* init method.                                                                                */
    /***********************************************************************************************/
    if ((self = [super initWithDelegate:theDelegate]))
    {
        [self->elementsArray addObject:@"ZERO"];
        [self->elementsArray addObject:@"ONE"];
        [self->elementsArray addObject:@"TWO"];
        [self->elementsArray addObject:@"THREE"];
        [self->elementsArray addObject:@"FOUR"];
    }
    
    return self;
}


#pragma mark - Ordered List Data Source Methods

- (void) fetchElementsBatch:(int)amount beforeAndIncluding:(id)elementId
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/
    /***********************************************************************************************/    
}


- (void) fetchElementsBatch:(int)amount afterAndIncluding:(id)elementId
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/    
    /***********************************************************************************************/    
}


- (void) fetchLatestElements:(int)amount
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/
    /* The latest element therefore will be inserted at the beginning of the array.                */
    /***********************************************************************************************/    
}

// --------------------------------------------------------------------------------------------------



#pragma mark - Memory Management

- (void)dealloc
{
    /***********************************************************************************************/
    /* Tidy-up                                                                                     */
    /***********************************************************************************************/
    [super dealloc];
}



@end
