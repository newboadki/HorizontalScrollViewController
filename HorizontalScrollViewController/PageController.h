//
//  PageViewController.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageController : UIViewController
{    
}

@property   NSUInteger index;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;

- (void) displayViewWithElement:(id)element;


@end
