//
//  NotebookController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotebookController.h"

// keys in our disk-based dictionary representing our outline view's data
#define KEY_NAME				@"name"
#define KEY_URL					@"url"
#define KEY_SEPARATOR			@"separator"
#define KEY_GROUP				@"group"
#define KEY_FOLDER				@"folder"
#define KEY_ENTRIES				@"entries"

@implementation NotebookController


- (id)init {
    self = [super init];
    if (self) {
        _initialize = YES;
    }
    return self;
}

- (void)awakeFromNib {
//    NSLog(@"test");
    if (_initialize) {
        _initialize = NO;
        [self insertStandardItems:nil];
    }
}

//- (void)insertStandardItems {
- (IBAction)insertStandardItems:(id)sender {
    NSMutableDictionary *mainItems = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"Header", @"Library", [NSMutableArray array], @"children", nil];
    NSMutableDictionary *subItems = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"All Songs", @"All Songs", @"isLeaf", @"isLeaf", nil];
    [[mainItems objectForKey: @"children"] addObject: subItems];
    
    [_notebookTree insertObject:mainItems atArrangedObjectIndexPath:[NSIndexPath indexPathWithIndex:0]];

//    [self addFolder:@"Library"];
//    [self populateOutline];
//    
//    NSArray *selection = [_notebookTree selectionIndexPaths];
//    [_notebookTree removeSelectionIndexPaths:selection];
}

- (void)addFolder:(NSString *)folderName {
	// NSTreeController inserts objects using NSIndexPath, so we need to calculate this
	NSIndexPath *indexPath = nil;
	
	// if there is no selection, we will add a new group to the end of the contents array
	if ([[_notebookTree selectedObjects] count] == 0) {
		// there's no selection so add the folder to the top-level and at the end
		indexPath = [NSIndexPath indexPathWithIndex:0];
	}
	else {
		// get the index of the currently selected node, then add the number its children to the path -
		// this will give us an index which will allow us to add a node to the end of the currently selected node's children array.
		//
		indexPath = [_notebookTree selectionIndexPath];
		if ([[[_notebookTree selectedObjects] objectAtIndex:0] isLeaf]) {
			// user is trying to add a folder on a selected child,
			// so deselect child and select its parent for addition
			[self selectParentFromSelection];
		}
		else {
			indexPath = [indexPath indexPathByAddingIndex:[[[[_notebookTree selectedObjects] objectAtIndex:0] children] count]];
		}
	}
	
	ChildNode *node = [[ChildNode alloc] init];
    node.nodeTitle = folderName;
	
	// the user is adding a child node, tell the controller directly
	[_notebookTree insertObject:node atArrangedObjectIndexPath:indexPath];
}

- (void)selectParentFromSelection {
	if ([[_notebookTree selectedNodes] count] > 0) {
		NSTreeNode *firstSelectedNode = [[_notebookTree selectedNodes] objectAtIndex:0];
		NSTreeNode *parentNode = [firstSelectedNode parentNode];
		if (parentNode) {
			// select the parent
			NSIndexPath *parentIndex = [parentNode indexPath];
			[_notebookTree setSelectionIndexPath:parentIndex];
		}
		else {
			// no parent exists (we are at the top of tree), so make no selection in our outline
			NSArray *selectionIndexPaths = [_notebookTree selectionIndexPaths];
			[_notebookTree removeSelectionIndexPaths:selectionIndexPaths];
		}
	}
}

- (void)populateOutline {
    // add the "Bookmarks" section
	[self addFolder:@"Notebooks"];
    
    NSDictionary *initData = [NSDictionary dictionaryWithContentsOfFile:
                              [[NSBundle mainBundle] pathForResource:@"outline" ofType:@"dict"]];
	NSDictionary *entries = [initData objectForKey:KEY_ENTRIES];
	[self addEntries:entries discloseParent:YES];
    
    [self selectParentFromSelection];
}

- (void)addEntries:(NSDictionary *)entries discloseParent:(BOOL)discloseParent {
	for (id entry in entries) {
		if ([entry isKindOfClass:[NSDictionary class]]) {
			NSString *urlStr = [entry objectForKey:KEY_URL];
			
			if ([entry objectForKey:KEY_SEPARATOR]) {
				// its a separator mark, we treat is as a leaf
				//[self addChild:nil withName:nil selectParent:YES];
                                NSLog(@"separator");
			}
			else if ([entry objectForKey:KEY_FOLDER]) {
				// we treat file system folders as a leaf and show its contents in the NSCollectionView
				NSString *folderName = [entry objectForKey:KEY_FOLDER];
				//[self addChild:urlStr withName:folderName selectParent:YES];
                                NSLog(@"folder");
			}
			else if ([entry objectForKey:KEY_URL]) {
				// its a leaf item with a URL
				NSString *nameStr = [entry objectForKey:KEY_NAME];
				//[self addChild:urlStr withName:nameStr selectParent:YES];
                NSLog(@"url");
			}
			else {
				// it's a generic container
				NSString *folderName = [entry objectForKey:KEY_GROUP];
				[self addFolder:folderName];
				
				// add its children
				NSDictionary *newChildren = [entry objectForKey:KEY_ENTRIES];
				[self addEntries:newChildren discloseParent:NO];
				
				[self selectParentFromSelection];
			}
		}
	}
	
	if (!discloseParent) {
        // inserting children automatically expands its parent, we want to close it
        if ([[_notebookTree selectedNodes] count] > 0) {
            NSTreeNode *lastSelectedNode = [[_notebookTree selectedNodes] objectAtIndex:0];
            [_notebooks collapseItem:lastSelectedNode];
        }
    }
}


#pragma mark -
#pragma mark Outline View Delagte methods

- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return 1;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item {
    return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return NO;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    NSTableCellView *view = nil;
    
    NSTreeNode *node = item;
//    if ([self isHeader:item]) {
//    if ([node.representedObject isKindOfClass:[Group class]]) {
//        view = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
//    } else {
        view = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
//    }
    return view;
}

- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object {
    return nil;
}

@end
