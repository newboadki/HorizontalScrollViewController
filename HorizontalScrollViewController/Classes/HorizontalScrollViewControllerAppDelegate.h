//
//  HorizontalScrollViewControllerAppDelegate.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias Drake on 14/07/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalScrollViewController.h"
#import "TextnumbersDataSource.h"
#import "PurplePageController.h"


@class HorizontalScrollViewController;

@interface HorizontalScrollViewControllerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HorizontalScrollViewController *viewController;
@property (nonatomic, retain) TextnumbersDataSource* dataSource;

@end
