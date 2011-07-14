//
//  OrderedListDataSourceTests.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 14/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "OrderedListDataSourceTests.h"


@implementation OrderedListDataSourceTests


- (void) setUp
{

}

- (void) tearDown
{

}

- (void) testConformsToOrderedListDataSourceProtocol
{
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] init];
 
    STAssertTrue([dataSource conformsToProtocol:@protocol(OrderedListDataSourceProtocol)], @"OrderedListDataSource class should conform to OrderedListDataSourceDelegateProtocol protocol");
    
    [dataSource release];
}


- (void) testInit
{
    DataSourceDelegateMock* delegateMock = [[DataSourceDelegateMock alloc] init];
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] initWithDelegate:delegateMock];
    
    STAssertNotNil(dataSource.dataSourceDelegate, @"the init method should set the delegate");    
    STAssertNotNil([dataSource valueForKey:@"elementsArray"], @"The init method should create an array of elements");
    
    [delegateMock release];
    [dataSource release];
}


- (void) testCount
{
    DataSourceDelegateMock* delegateMock = [[DataSourceDelegateMock alloc] init];
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] initWithDelegate:delegateMock];
    NSArray* array = [NSArray arrayWithObjects:@"A", @"B", @"C", nil];
    
    [dataSource setValue:array forKey:@"elementsArray"];
    
    STAssertTrue([dataSource count] == 3, @"count should return the number of elements in the elements array");    
    
    [delegateMock release];
    [dataSource release];    
}

- (void) testElementAtIndex
{
    DataSourceDelegateMock* delegateMock = [[DataSourceDelegateMock alloc] init];
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] initWithDelegate:delegateMock];
    NSArray* array = [NSArray arrayWithObjects:@"A", @"B", @"C", nil];
    
    [dataSource setValue:array forKey:@"elementsArray"];
    
    STAssertTrue([[dataSource elementAtIndex:0] isEqualToString:@"A"], @"elementAtIndex fails");    
    STAssertTrue([[dataSource elementAtIndex:1] isEqualToString:@"B"], @"elementAtIndex fails");    
    STAssertTrue([[dataSource elementAtIndex:2] isEqualToString:@"C"], @"elementAtIndex fails");    
    STAssertNil([dataSource elementAtIndex:-2], @"elementAtIndex fails");    
    STAssertNil([dataSource elementAtIndex:5], @"elementAtIndex fails");    


    [delegateMock release];
    [dataSource release];    
}


- (void) testFetchElementBatchBeforeAndIncluding
{
    DataSourceDelegateMock* delegateMock = [[DataSourceDelegateMock alloc] init];
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] initWithDelegate:delegateMock];
    id mock = [OCMockObject mockForClass:[NSObject class]];
        
    STAssertThrows([dataSource fetchElementsBatch:10 beforeAndIncluding:mock], @"fetchElementsBatch:beforeAndIncluding: should raise an exception");    
    
    [DataSourceDelegateMock release];
    [dataSource release];    
}


- (void) testFetchElementBatchAfterAndIncluding
{
    DataSourceDelegateMock* delegateMock = [[DataSourceDelegateMock alloc] init];
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] initWithDelegate:delegateMock];
    id mock = [OCMockObject mockForClass:[NSObject class]];
    
    STAssertThrows([dataSource fetchElementsBatch:10 afterAndIncluding:mock], @"fetchElementsBatch:afterAndIncluding: should raise an exception");    
    
    [DataSourceDelegateMock release];
    [dataSource release];    
}


- (void) testFetchLatestElements
{
    DataSourceDelegateMock* delegateMock = [[DataSourceDelegateMock alloc] init];
    OrderedListDataSource* dataSource = [[OrderedListDataSource alloc] initWithDelegate:delegateMock];
    
    STAssertThrows([dataSource fetchLatestElements:20], @"fetchElementsBatch:beforeAndIncluding: should raise an exception");    
    
    [DataSourceDelegateMock release];
    [dataSource release];    
}


@end
