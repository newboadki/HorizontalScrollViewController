//
//  ScrollPageViewController.m
//  PhotoScroller
//
//  Created by Borja Arias Drake on 06/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "PurplePageController.h"


@implementation PurplePageController

@synthesize textLabel;



#pragma mark - Rotation helpers

- (CGPoint)pointToCenterAfterRotation{ return CGPointMake(0.0, 0.0); }
- (CGFloat)scaleToRestoreAfterRotation{ return 0.0; }
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale{}



#pragma mark - Customize the view

- (void) displayViewWithElement:(id)element
{
    textLabel.text = [element description];
}



#pragma mark - CustomViewController Protocol

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



#pragma mark - Memory Management

- (void) dealloc
{
    /**********************************************************************************************
     * Tidy-up
     ***********************************************************************************************/
    [self setTextLabel:nil];    
    [super dealloc];
}

@end