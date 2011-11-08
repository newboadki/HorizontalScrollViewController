//
//  PageViewController.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewControllerProtocol.h"

@interface PageController : NSObject <CustomViewControllerProtocol>
{    
}

@property   NSUInteger index;
@property (retain, nonatomic) UIView* view;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;
- (void) displayViewWithElement:(id)element;
- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle;

@end
