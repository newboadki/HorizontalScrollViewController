//
//  ScrollPageViewController.h
//  PhotoScroller
//
//  Created by Borja Arias Drake on 06/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScrollPageViewController : UIViewController
{

}

@property   NSUInteger index;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;

- (void) displayViewWithElement:(id)element;

@end
