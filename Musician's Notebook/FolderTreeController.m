//
//  FolderTreeController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/4/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "FolderTreeController.h"

@implementation FolderTreeController

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return [[item children] count];
}

// Method returns flag, whether we can expand given tree node item or not
// (here is the simple rule, we can expand only nodes having one and more children)
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
     return ([item respondsToSelector:@selector(children)] && ([[item children] count] > 0));
}

// Method returns value to be shown for given column of the tree node item
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    return [item valueForKey:[tableColumn identifier]];
}

// Method returns children item for given tree node item by given index
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    //return (DASchemaBaseObject*)[[item children] objectAtIndex:index];
    return nil;
}

@end
