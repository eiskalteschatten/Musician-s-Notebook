//
//  Notebook.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/25/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "Notebook.h"

@implementation Notebook

+ (Notebook *)notebookWithTitle:(NSString *)title andImage:(NSImageView *)imageView {
    Notebook *result = [Notebook new];
    result.title = title;
    result.imageView = nil;//imageView;
    
    return result;
}

- (BOOL)isLeaf{
    return YES;
}

@end
