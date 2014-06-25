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
     //   [self fillNotebooks];
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
    
    [_notebookTree addObject:root];
}

- (BOOL)isHeader:(id)item {
    if([item isKindOfClass:[NSTreeNode class]]){
        return ![((NSTreeNode *)item).representedObject isKindOfClass:[Notebook class]];
    } else {
        return ![item isKindOfClass:[Notebook class]];
    }
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
