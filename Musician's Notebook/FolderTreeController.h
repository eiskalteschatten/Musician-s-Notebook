//
//  FolderTreeController.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/4/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"

@interface FolderTreeController : NSTreeController

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSOutlineView *folderView;
@property (assign) IBOutlet MainViewController *mainViewContoller;

@end
