//
//  NotebookController.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChildNode.h"

@interface NotebookController : NSObject

@property (assign) IBOutlet NSTreeController *notebookTree;
@property (assign) IBOutlet NSOutlineView *notebooks;

@property (assign) BOOL initialize;

//- (void)insertStandardItems;
- (IBAction)insertStandardItems:(id)sender;
- (void)addFolder:(NSString *)folderName;
- (void)selectParentFromSelection;
- (void)populateOutline;
- (void)addEntries:(NSDictionary *)entries discloseParent:(BOOL)discloseParent;

@end
