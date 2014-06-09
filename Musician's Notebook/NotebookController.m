//
//  NotebookController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotebookController.h"

@implementation NotebookController


- (void)awakeFromNib {
//    NSMutableDictionary *root = @{@"title": @"BOOKS",
//                                  @"isLeaf": @(NO),
//                                  @"children":@[
//                                          [Book bookWithTitle:@"To Kill a Mockingbird" andAuthor:@"Harper Lee"],
//                                          [Book bookWithTitle:@"Pride and Prejudice" andAuthor:@"Jane Austen"],
//                                          [Book bookWithTitle:@"The Catcher in the Rye" andAuthor:@"J.D. Salinger"]
//                                          ].mutableCopy
//                                  }.mutableCopy;

    NSMutableDictionary *mainItems = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"Header", @"Library", [NSMutableArray array], @"children", nil];
    NSMutableDictionary *subItems = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"All Songs", @"All Songs", [NSMutableArray array], @"children", nil];
    [[mainItems objectForKey: @"children"] addObject: subItems];
    
//    [_notebookTree insertObject:mainItems atArrangedObjectIndexPath:[NSIndexPath indexPathWithIndex:0]];
}

- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return nil;
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
    
//    if ([node.representedObject isKindOfClass:[Group class]]) {
//        view = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
//    } else {
        view = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
//    }
    return view;
}

@end
