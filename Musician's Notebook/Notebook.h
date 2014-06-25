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
@property (copy) NSImageView *imageView;

+ (Notebook*)notebookWithTitle:(NSString *)title andImage:(NSImageView *)imageView;

@property (readonly) BOOL isLeaf;

@end
