//
//  NotebookController.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notebook.h"
#import "NotebookDataSource.h"

@interface NotebookController : NSObject <NSOutlineViewDelegate>

@property (assign) IBOutlet NSTreeController *notebookTree;
@property (assign) IBOutlet NSOutlineView *notebooks;
@property (assign) IBOutlet NotebookDataSource *notebookDataSource;

@property (assign) BOOL initialize;

- (void)insertStandardItems;
- (void)fillNotebooks;
- (BOOL)isHeader:(id)item;

@end
