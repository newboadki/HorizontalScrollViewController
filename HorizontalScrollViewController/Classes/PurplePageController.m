//
//  ScrollPageViewController.m
//  PhotoScroller
//
//  Created by Borja Arias Drake on 06/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "PurplePageController.h"

@interface PurplePageController()
@property (retain, nonatomic) UILabel* textLabel;
@end

@implementation PurplePageController

@synthesize textLabel;



#pragma mark - Initializator Methods

- (id) init
{
    /**********************************************************************************************
     * 
     ***********************************************************************************************/
    self = [super init];

    if(self)
    {
        UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 50)];
        [l setBackgroundColor:[UIColor clearColor]];
        [self setTextLabel:l];
        [l release];        
        [self.view addSubview:self.textLabel];
    }
    
    return self;
}



#pragma mark - Rotation helpers

- (CGPoint)pointToCenterAfterRotation{}
- (CGFloat)scaleToRestoreAfterRotation{}
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale{}



#pragma mark - Customize the view

- (void) displayViewWithElement:(id)element
{
    textLabel.text = [element description];
    [self.view setBackgroundColor:[UIColor purpleColor]];        
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