//
//  HorizontalScrollViewControllerAppDelegate.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 14/07/2011.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalScrollViewControllerViewController;

@interface HorizontalScrollViewControllerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HorizontalScrollViewControllerViewController *viewController;

@end
