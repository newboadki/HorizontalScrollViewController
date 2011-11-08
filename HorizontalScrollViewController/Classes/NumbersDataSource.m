//
//  NumbersDataSource.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias on 07/11/2011.
//  Copyright (c) 2011 Unboxed Consulting. All rights reserved.
//

#import "NumbersDataSource.h"

// This is the hack of the century. I don't know how to declare a protected ivar/property in a superclass' extension. so I repeat it here
// to shut the compiler up. This is the only way I know so the property is still defined privately and not in a header file
@interface OrderedListDataSource()
@property (nonatomic, retain) NSMutableArray* elementsArray;
@end


@implementation NumbersDataSource


- (id) initWithDelegate:(id <OrderedListDataSourceDelegateProtocol>)theDelegate
{
    /***********************************************************************************************/
    /* init method.                                                                                */
    /***********************************************************************************************/
    if ((self = [super initWithDelegate:theDelegate]))
    {
        [self.elementsArray addObject:[NSNumber numberWithInt:0]];
        [self.elementsArray addObject:[NSNumber numberWithInt:1]];
        [self.elementsArray addObject:[NSNumber numberWithInt:2]];
        [self.elementsArray addObject:[NSNumber numberWithInt:3]];
        [self.elementsArray addObject:[NSNumber numberWithInt:4]];    
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
