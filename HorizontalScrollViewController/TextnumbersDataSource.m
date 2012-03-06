//
//  TextnumbersDataSource.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias on 08/11/2011.
//  Copyright (c) 2011 Borja Arias Drake. All rights reserved.
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
        [self->elementsArray addObject:@"0"];
        [self->elementsArray addObject:@"1"];
        [self->elementsArray addObject:@"2"];
        [self->elementsArray addObject:@"3"];
        [self->elementsArray addObject:@"4"];
        self->firstIndex = 0;
        self->lastIndex = 4;
    }
    
    return self;
}




#pragma mark - Ordered List Data Source Methods

- (void) fetchElementsBatch:(int)amount beforeAndIncluding:(id)elementId
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/
    /***********************************************************************************************/    
    //NSNumber* oldIndexNumber = (NSNumber*)elementId;
    
    for (int i=1; i<=5; i++)
    {
        (self->firstIndex)--;
        [self->elementsArray insertObject:[NSString stringWithFormat:@"%d", self->firstIndex] atIndex:0];
    }
    
    sleep(2);
    [dataSourceDelegate fetchedElementsAtTheBeginingWithOffset:5];
}


- (void) fetchElementsBatch:(int)amount afterAndIncluding:(id)elementId
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. after means closer to the last.*/    
    /***********************************************************************************************/    
    //NSNumber* oldIndexNumber = (NSNumber*)elementId;
    
    for (int i=1; i<=5; i++)
    {
        (self->lastIndex)++;    
        [self->elementsArray addObject:[NSString stringWithFormat:@"%d", self->lastIndex]];
    }
    
    sleep(2);
    [dataSourceDelegate fetchedElementsAtTheEndWithOffset:5];
}


- (void) fetchLatestElements:(int)amount
{
    /***********************************************************************************************/
    /* In an ordered list there's a first element and a last one. Before means closer to the first.*/
    /* The latest element therefore will be inserted at the end of the array.                      */
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
