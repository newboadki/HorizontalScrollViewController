//
//  OrderedListDataSource.h
//  FanApp
//
//  Created by Borja Arias Drake on 17/06/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedListDataSourceDelegateProtocol.h"
#import "OrderedListDataSourceProtocol.h"

@interface OrderedListDataSource : NSObject <OrderedListDataSourceProtocol>
{
    @protected
      NSMutableArray* elementsArray;
}

@property (nonatomic, assign) id <OrderedListDataSourceDelegateProtocol> dataSourceDelegate;

- (id) initWithDelegate:(id <OrderedListDataSourceDelegateProtocol>)theDelegate;
- (int) count;
- (id) elementAtIndex:(NSInteger)index;
- (void) fetchElementsBatch:(int)amount beforeAndIncluding:(id)elementId;
- (void) fetchElementsBatch:(int)amount afterAndIncluding:(id)elementId;
- (void) fetchLatestElements:(int)amount;

@end
