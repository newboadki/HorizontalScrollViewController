//
//  BasicDataSourceDelegateProtocol.h
//  FanApp
//
//  Created by Borja Arias Drake on 14/06/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol OrderedListDataSourceDelegateProtocol <NSObject>
- (void) fetchedElementsAtTheBeginingWithOffset:(NSInteger)offset;
- (void) fetchedElementsAtTheEndWithOffset:(NSInteger)offset;
- (void) countDidNotChange;
@end
