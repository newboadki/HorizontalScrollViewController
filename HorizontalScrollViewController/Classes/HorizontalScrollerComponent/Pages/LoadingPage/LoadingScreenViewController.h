//
//  LoadingScreenViewController.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 23/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageController.h"

@interface LoadingScreenViewController : PageController
{    
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView* spinnerView;
@property (retain, nonatomic) IBOutlet UILabel*                 loadingLabel;

@end
