//
//  NotebookDataSource.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/25/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotebookDataSource.h"

@implementation NotebookDataSource

- (id)outlineView:(NSOutlineView *)outlineView persistentObjectForItem:(id)item {
    NSNumber *uid=[[item representedObject] valueForKeyPath:@"uid"];
    id archivedObject=[NSKeyedArchiver archivedDataWithRootObject:uid];
    return archivedObject;
    //return [NSKeyedArchiver archivedDataWithRootObject:item];
    //return nil;
}

- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object {
    return [NSKeyedUnarchiver unarchiveObjectWithData:object];
}

@end
