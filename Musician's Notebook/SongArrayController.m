//
//  SongArrayController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/6/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "SongArrayController.h"

@implementation SongArrayController

-(id)newObject {
    id newObj = [super newObject];
    [newObj setValue:[NSImage imageNamed:@"Music Note"] forKey:@"artwork"];

    return newObj;
}

@end
