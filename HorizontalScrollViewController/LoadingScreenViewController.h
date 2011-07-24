//
//  LoadingScreenViewController.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface LoadingScreenViewController : PageViewController
{    
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView* spinnerView;
@property (retain, nonatomic)   IBOutlet UILabel*                 loadingLabel;

@end
