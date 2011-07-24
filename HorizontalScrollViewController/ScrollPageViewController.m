//
//  ScrollPageViewController.m
//  PhotoScroller
//
//  Created by Borja Arias Drake on 06/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "ScrollPageViewController.h"

@interface ScrollPageViewController()
@property (retain, nonatomic) UILabel* textLabel;
@end

@implementation ScrollPageViewController

@synthesize textLabel;

- (id) init
{
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

- (CGPoint)pointToCenterAfterRotation{}
- (CGFloat)scaleToRestoreAfterRotation{}
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale{}


- (void) displayViewWithElement:(id)element
{
    textLabel.text = element;
    [self.view setBackgroundColor:[UIColor purpleColor]];        
}


- (void) dealloc
{
    [self setTextLabel:nil];
    
    [super dealloc];
}
@end
