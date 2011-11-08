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


#pragma mark - Rotation helpers

- (CGPoint)pointToCenterAfterRotation{}
- (CGFloat)scaleToRestoreAfterRotation{}
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale{}



#pragma mark - Customize the view

- (void) displayViewWithElement:(id)element
{
    // Because this class inherits from a Page we have this method called, but we do nothing.
    // And actually if this is the case it caller should pass nil or not call it at all.
}



#pragma mark - CustomViewController Protocol

- (void)viewWillAppear:(BOOL)animated{}
- (void)viewDidAppear:(BOOL)animated{}
- (void)viewWillDisappear:(BOOL)animated{}
- (void)viewDidDisappear:(BOOL)animated{}



#pragma mark - Memory Management

- (void) dealloc
{
    /**********************************************************************************************
     * Tidy-up
     ***********************************************************************************************/
    [self setSpinnerView:nil];
    [self setLoadingLabel:nil];
    
    [super dealloc];
}

@end
