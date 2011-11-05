//
//  PageViewController.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "PageController.h"


@implementation PageController

@synthesize index;
@synthesize view;

- (id) init
{
    /**********************************************************************************************
    * Returns true if there is a page in the visiblePages set with the sought index.              
	***********************************************************************************************/
    if ((self = [super init]))
    {
        UIView* theView = [[UIView alloc] init];
        [self setView:theView];
        [theView release];
    }

    return self;
}



#pragma mark - Rotation helpers

- (CGPoint)pointToCenterAfterRotation{}
- (CGFloat)scaleToRestoreAfterRotation{}
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale{}



#pragma mark - Customize the view

- (void) displayViewWithElement:(id)element{}



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
    [self setView:nil];
    [super dealloc];
}

@end