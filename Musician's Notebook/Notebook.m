//
//  Notebook.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/25/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "Notebook.h"

@implementation Notebook

+ (Notebook *)notebookWithTitle:(NSString *)title {
    Notebook *result = [Notebook new];
    result.title = title;
    result.imageView = [NSImage imageNamed:@"Music Note"];
    result.stdImageView = [NSImage imageNamed:@"Music Note"];
    result.altImageView = [NSImage imageNamed:@"Music Note Alt"];
    
    return result;
}

- (BOOL)isLeaf {
    return YES;
}

- (void)setAltImage {
    //self.imageView = self.altImageView;
}

- (void)removeAltImage {
    self.imageView = self.stdImageView;
}

@end
