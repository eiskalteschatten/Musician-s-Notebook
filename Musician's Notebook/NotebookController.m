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
        [self setupNotebooks];
    }
}

- (void)setupNotebooks {    
    NSMutableDictionary *root = @{@"title": @"LIBRARY",
                                  @"isLeaf": @(NO),
                                  @"children":@[
                                          [Notebook notebookWithTitle:@"All Songs"]
                                          ].mutableCopy
                                  }.mutableCopy;
    
    [_notebookTree addObject:root];
    [_contents addObject:root];
    
    
    NSMutableDictionary *notebooks = @{@"title": @"NOTEBOOKS",
                                  @"isLeaf": @(NO),
                                  @"children":@[
                                          [Notebook notebookWithTitle:@"Untitled Notebook"]
                                          ].mutableCopy
                                  }.mutableCopy;
    
    NSInteger row = _contents.count + 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:row];
    
    [_notebookTree insertObject:notebooks atArrangedObjectIndexPath:indexPath];
  
    _contents = [[NSMutableArray alloc] init];
    [_contents addObject:notebooks];
    
    [_notebooks expandItem:[_notebooks itemAtRow:0]];
    [_notebooks expandItem:[_notebooks itemAtRow:row+1]];
    [_notebooks selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
    [_notebooks registerForDraggedTypes: [NSArray arrayWithObject: @"public.text"]];
}

- (BOOL)isHeader:(id)item {
    if ([item isKindOfClass:[NSTreeNode class]]) {
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
    Notebook *notebook = [Notebook notebookWithTitle:@"New Notebook"];
    
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

- (void)outlineViewSelectionIsChanging:(NSNotification *)notification {
    NSArray *objects = [_notebookTree selectedObjects];
    
    for (int i = 0; i < [objects count]; i++) {
        id object = [objects objectAtIndex:i];
        if ([object isKindOfClass:[Notebook class]]) {
            [object removeAltImage];
        }
    }
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSArray *objects = [_notebookTree selectedObjects];
    
    for (int i = 0; i < [objects count]; i++) {
        id object = [objects objectAtIndex:i];
        if ([object isKindOfClass:[Notebook class]]) {
            [object setAltImage];
        }
    }
}

- (id <NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView pasteboardWriterForItem:(id)item {
    BOOL dragAllowed = YES;
    if (!dragAllowed) {
        return nil;
    }
    
    Notebook *notebook = (Notebook *)(((NSTreeNode *)item).representedObject);
    NSString *identifier = notebook.title;
    
    NSPasteboardItem *pboardItem = [[NSPasteboardItem alloc] init];
    [pboardItem setString:identifier forType: @"public.text"];
    
    return pboardItem;
}


- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id < NSDraggingInfo >)info proposedItem:(id)targetItem proposedChildIndex:(NSInteger)index {
    BOOL canDrag = index >= 0 && targetItem;
    
    if (canDrag) {
        return NSDragOperationMove;
    }
    else {
        return NSDragOperationNone;
    }
}


- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id < NSDraggingInfo >)info item:(id)targetItem childIndex:(NSInteger)index {
    NSPasteboard *p = [info draggingPasteboard];
    NSString *title = [p stringForType:@"public.text"];
    NSTreeNode *sourceNode;
    
    for (NSTreeNode *b in [targetItem childNodes]) {
        if ([[[b representedObject] title] isEqualToString:title]) {
            sourceNode = b;
        }
    }
    
    if (!sourceNode) {
        return NO;
    }
    
    NSUInteger indexArr[] = {0,index};
    NSIndexPath *toIndexPATH =[NSIndexPath indexPathWithIndexes:indexArr length:2];
    
    [_notebookTree moveNode:sourceNode toIndexPath:toIndexPATH];
    
    return YES;
}


@end
