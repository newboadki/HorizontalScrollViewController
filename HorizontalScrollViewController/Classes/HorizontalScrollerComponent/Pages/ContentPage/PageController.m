//
//  PageViewController.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "PageController.h"
#import "HorizontalScrollViewController.h"

@interface PageController()

@end

@implementation PageController

@synthesize index;
@synthesize view;



#pragma mark - Initialisers

- (id) init
{
    /**********************************************************************************************
    * 
	***********************************************************************************************/
    if ((self = [super init]))
    {
        UIView* theView = [[UIView alloc] init];
        [self setView:theView];
        [theView release];
    }

    return self;
}


- (id) initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle
{
    /**********************************************************************************************
     * There's some Apple magic going on here. loadNibNamed:owner: loads the nib file and then 
     * assigns it to the view!!! That's why we don't set it as in 'init'. I guess that 
     * initWithNibName:bundle does that for UIViewControllers as view controllers have a view. 
     * We are mimicking viewControllers here so it's not that bad.
     ***********************************************************************************************/
    if ((self = [super init]))
    {        
        [bundle loadNibNamed:nibName owner:self options:nil];
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