//
//  NotebookController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotebookController.h"

@implementation NotebookController

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    NSTableCellView *view = nil;
    
    NSTreeNode *node = item;
    
//    if ([node.representedObject isKindOfClass:[Group class]]) {
//        view = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
//    } else {
        view = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
//    }
    return view;
}

@end
