//
//  MainScreenMock.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 17/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "MainScreenMock.h"


@implementation MainScreenMock

- (CGRect) bounds
{
    return CGRectMake(0.0, 0.0, 320.0, 480.0);
}


- (CGFloat) scale
{
    return 1.0;
}


- (CGRect) applicationFrame
{
   return CGRectMake(0.0, 0.0, 320.0, 480.0); 
}


@end
