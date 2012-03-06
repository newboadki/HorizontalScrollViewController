//
//  DataSourceMock.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 14/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedListDataSourceDelegateProtocol.h"

@interface DataSourceDelegateMock : NSObject <OrderedListDataSourceDelegateProtocol>
{
    
}

- (void) countDidChangeWithOffset:(NSInteger)offset;
- (void) countDidNotChange;

@end
