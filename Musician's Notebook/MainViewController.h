//
//  MainViewController.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SongsViewController.h"

@interface MainViewController : NSViewController

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *mainView;
@property (strong) NSViewController *currentViewController;
@property (strong) IBOutlet SongsViewController *songsViewController;
@property (strong) IBOutlet NSSplitView *splitView;

- (void)setMainViewTo:(NSViewController *)controller;
- (void)showSongsView;

@end
