//
//  Notebook.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/25/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notebook : NSObject

@property (copy) NSString *title;
@property (copy) NSImage *imageView;
@property (copy) NSImage *stdImageView;
@property (copy) NSImage *altImageView;

+ (Notebook*)notebookWithTitle:(NSString *)title;

@property (readonly) BOOL isLeaf;

- (void)setAltImage;
- (void)removeAltImage;

@end
