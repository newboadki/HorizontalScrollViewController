//
//  OrderedListDataSourceProtocol.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 14/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol OrderedListDataSourceProtocol
- (id) initWithDelegate:(id <OrderedListDataSourceDelegateProtocol>)theDelegate;
- (int) count;
- (id) elementAtIndex:(NSInteger)index;
- (void) fetchElementsBatch:(int)amount beforeAndIncluding:(id)elementId;
- (void) fetchElementsBatch:(int)amount afterAndIncluding:(id)elementId;
- (void) fetchLatestElements:(int)amount;
@end
