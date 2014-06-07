//
//  SongsViewController.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SongArrayController.h"

@interface SongsViewController : NSViewController

@property (strong) IBOutlet NSSplitView *splitView;
@property (assign) IBOutlet NSTabView *tabView;
@property (assign) IBOutlet NSTableView *songView;
@property (assign) IBOutlet SongArrayController *songArray;

@property (assign) NSInteger clickedSegment;

- (IBAction)switchTab:(id)sender;
- (IBAction)addSong:(id)sender;

@end
