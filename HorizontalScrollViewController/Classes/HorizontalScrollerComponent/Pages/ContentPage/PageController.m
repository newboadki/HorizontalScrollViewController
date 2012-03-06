//
//  PageViewController.m
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
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
     
     * Stupid me, of course it links it to the view. loadNibFile, just unarchives the content
     * of the nib file and stablishes the connections with the passed owner. I guess I'm jsut a bit
     * puzzled with the fact that there was no IBOutlet. 
     ***********************************************************************************************/
    if ((self = [super init]))
    {        
        [bundle loadNibNamed:nibName owner:self options:nil];
    }
    
    return self;
}



#pragma mark - Rotation helpers

- (CGPoint)pointToCenterAfterRotation{ return CGPointMake(0.0, 0.0); }
- (CGFloat)scaleToRestoreAfterRotation{ return 0.0; }
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