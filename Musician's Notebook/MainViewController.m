//
//  MainViewController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib {
    [self showSongsView];
    [_splitView setHoldingPriority:NSLayoutPriorityDragThatCanResizeWindow forSubviewAtIndex:0];
}

- (void)setMainViewTo:(NSViewController *)controller {
    //Remove existing subviews
    while ([[_mainView subviews] count] > 0) {
        [_mainView.subviews[0] removeFromSuperview];
    }
    
    NSView *view = [controller view];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_mainView addSubview:view];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(view);
    [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    
    _currentViewController = controller;
}

- (void)showSongsView {
    [self setMainViewTo:_songsViewController];
}

@end
