//
//  MainWindowViewContoller.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NotebooksView.h"

@interface MainWindowViewContoller : NSViewController

@property (retain) IBOutlet NotebooksView *notebooksView;
@property (assign) IBOutlet NSOutlineView *notebooksSourceList;

@end
