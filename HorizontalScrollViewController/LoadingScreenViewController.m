//
//  LoadingScreenViewController.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "LoadingScreenViewController.h"


@implementation LoadingScreenViewController

@synthesize loadingLabel;
@synthesize spinnerView;


- (CGPoint)pointToCenterAfterRotation{}
- (CGFloat)scaleToRestoreAfterRotation{}
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale{}


- (void) displayViewWithElement:(id)element
{
    // Because this class inherits from a Page we have this method called, but we do nothing.
    // And actually if this is the case it caller should pass nil or not call it at all.
}




- (void)dealloc
{
    [self setSpinnerView:nil];
    [self setLoadingLabel:nil];
    
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    // Release any cached data, images, etc that aren't in use.
    [super didReceiveMemoryWarning];
    

}

@end
