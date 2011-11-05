//
//  CustomViewControllerProtocol.h
//  HorizontalScrollViewController
//
//  Created by Borja Arias on 05/11/2011.
//  Copyright (c) 2011 Unboxed Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomViewControllerProtocol <NSObject>

  @property (retain, nonatomic) UIView* view;
  - (void)viewWillAppear:(BOOL)animated;
  - (void)viewDidAppear:(BOOL)animated;
  - (void)viewWillDisappear:(BOOL)animated;
  - (void)viewDidDisappear:(BOOL)animated;

@end
