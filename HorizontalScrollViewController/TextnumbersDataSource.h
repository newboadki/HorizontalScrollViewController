//
//  TextnumbersDataSource.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias on 08/11/2011.
//  Copyright (c) 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedListDataSource.h"

@interface TextnumbersDataSource : OrderedListDataSource
{
    int firstIndex;
    int lastIndex;
}


@end
