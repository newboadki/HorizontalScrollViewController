//
//  BasicDataSourceDelegateProtocol.h
//  FanApp
//
//  Created by Borja Arias Drake on 14/06/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol OrderedListDataSourceDelegateProtocol <NSObject>
- (void) countDidChangeWithOffset:(NSInteger)offset;
- (void) countDidNotChange;
@end
