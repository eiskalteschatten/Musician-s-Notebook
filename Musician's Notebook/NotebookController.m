//
//  NotebookController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotebookController.h"

@implementation NotebookController


- (id)init {
    self = [super init];
    if (self) {
        _initialize = YES;
    }
    return self;
}

- (void)awakeFromNib {
    if (_initialize) {
        _initialize = NO;
        [_notebooks setDataSource:_notebookDataSource];
        [self insertStandardItems];
        [self fillNotebooks];
    }
}

- (void)insertStandardItems {
    NSImageView *allSongsView = [[NSImageView alloc] init];
    [allSongsView setImage: [NSImage imageNamed:@"Music Note"]];
    
    NSMutableDictionary *root = @{@"title": @"LIBRARY",
                                  @"isLeaf": @(NO),
                                  @"children":@[
                                          [Notebook notebookWithTitle:@"All Songs" andImage:allSongsView]
                                          ].mutableCopy
                                  }.mutableCopy;
    
    [_notebookTree addObject:root];
    
    [_notebooks expandItem:[_notebooks itemAtRow:0]];
    [_notebooks selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
}

- (void)fillNotebooks {
    NSImageView *allSongsView = [[NSImageView alloc] init];
    [allSongsView setImage: [NSImage imageNamed:@"Music Note"]];
    
    NSMutableDictionary *root = @{@"title": @"NOTEBOOKS",
                                  @"isLeaf": @(NO),
                                  @"children":@[
                                          [Notebook notebookWithTitle:@"All Songs" andImage:allSongsView]
                                          ].mutableCopy
                                  }.mutableCopy;
    
    NSIndexPath *indexPath = [_notebookTree selectionIndexPath];
    
    if ([[_notebookTree selectedObjects] count] == 0) {
        NSLog(@"test");
    }
    if ([[[_notebookTree selectedObjects] objectAtIndex:0] isLeaf]) {
        [self selectParentFromSelection];
    }
    else {
        indexPath = [indexPath indexPathByAddingIndex:[[[[_notebookTree selectedObjects] objectAtIndex:0] children] count]];
    }
    
    [_notebookTree insertObject:root atArrangedObjectIndexPath:indexPath];
}

- (BOOL)isHeader:(id)item {
    if([item isKindOfClass:[NSTreeNode class]]){
        return ![((NSTreeNode *)item).representedObject isKindOfClass:[Notebook class]];
    }
    else {
        return ![item isKindOfClass:[Notebook class]];
    }
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


#pragma mark -
#pragma mark Add and remove controls

- (IBAction)addNotebook:(id)sender {
    NSImageView *allSongsView = [[NSImageView alloc] init];
    [allSongsView setImage: [NSImage imageNamed:@"Music Note"]];
    Notebook *notebook = [Notebook notebookWithTitle:@"New Notebook" andImage:allSongsView];
    
    NSIndexPath *indexPath = [_notebookTree selectionIndexPath];
    
    if ([[[_notebookTree selectedObjects] objectAtIndex:0] isLeaf]) {
        [self selectParentFromSelection];
    }
    else {
        indexPath = [indexPath indexPathByAddingIndex:[[[[_notebookTree selectedObjects] objectAtIndex:0] children] count]];
    }
    
    [_notebookTree insertObject:notebook atArrangedObjectIndexPath:indexPath];
}

- (IBAction)removeNotebook:(id)sender {
    
}


#pragma mark -
#pragma mark Outline View Delagte methods

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    if ([self isHeader:item]) {
        return [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
    }
    else {
        return [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return [self isHeader:item];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    return ![self isHeader:item];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    
}

@end
