//
//  NotebooksView.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotebooksView.h"

@implementation NotebooksView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib {
    _bgColor = [NSColor blackColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    [_bgColor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (void)setBackgroundColor:(NSColor*)color {
    _bgColor = color;
    [self setNeedsDisplay:YES];
}

@end
