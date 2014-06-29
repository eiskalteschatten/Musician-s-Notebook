//
//  TabsViewController.h
//  Musician's Notebook
//
//  Created by Alex Seifert on 6/29/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabsViewController : NSObject <NSTextViewDelegate>

@property (retain) IBOutlet NSTextView *tabsView;

@property (assign) NSFont *defaultFont;

@end
