//
//  TabsViewController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/29/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "TabsViewController.h"

@implementation TabsViewController

- (id)init {
    self = [super init];
    if (self) {
        _defaultFont = [NSFont fontWithName:@"Courier" size:13];
    }
    return self;
}

- (void)awakeFromNib {
    [[_tabsView textStorage] setFont:_defaultFont];
}

- (void)textViewDidChangeSelection:(NSNotification *)note {
    NSTextView* textView = [note object];
    [textView setFont:_defaultFont];
}

@end
