//
//  SongsViewController.m
//  Musician's Notebook
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "SongsViewController.h"

@interface SongsViewController ()

@end

@implementation SongsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib {
    [_splitView setHoldingPriority:NSLayoutPriorityDragThatCanResizeWindow forSubviewAtIndex:0];
}

- (IBAction)switchTab:(id)sender {
    _clickedSegment = [sender selectedSegment];
    
    [_tabView selectTabViewItemAtIndex:_clickedSegment];
}

#pragma mark -
#pragma mark Song methods

- (IBAction)addSong:(id)sender {
    [_songArray add:self];
    
    
}

#pragma mark -
#pragma mark Table View Delagte methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    //return [_noteController getNumberOfNotes];
    return 0;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
        
        [cellView.imageView setImage:[NSImage imageNamed:@"Music Note"]];
        //[cellView.subviews[1] setStringValue:@"New Song"];
        //[cellView.subviews[2] setStringValue:@"test"];

        
       //NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:currentNote];
       //[tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        
        return cellView;
    }
    
    return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
//    _selectedNote = [pageList selectedRow];
//    
//    if (_selectedNote != -1) {
//        [_textViewController loadNote:_selectedNote];
//    }
//    else {
//        // No row was selected
//    }
}

@end
