//
//  MainWindowViewContoller.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/8/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "MainWindowViewContoller.h"

@interface MainWindowViewContoller ()

@end

@implementation MainWindowViewContoller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
    NSColor *bgColor = [_notebooksSourceList backgroundColor];
    [_notebooksView setBackgroundColor:bgColor];
}

- (void)windowDidResignKey:(NSNotification *)notification {
    NSColor *bgColor = [_notebooksSourceList backgroundColor];
    [_notebooksView setBackgroundColor:bgColor];
}

@end
