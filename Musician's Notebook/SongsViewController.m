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
    
}

- (IBAction)switchTab:(id)sender {
    _clickedSegment = [sender selectedSegment];
    
    [self changeTab:_clickedSegment];
}

- (void)changeTab:(NSInteger)tabIndex {
    [_tabView selectTabViewItemAtIndex:tabIndex];
    [_tabControl setSelectedSegment:tabIndex];
    
    if ([[[_tabView selectedTabViewItem] label]  isEqual: @"Lyrics"]) {
        [_window makeFirstResponder:_lyricsView];
    }
    else if ([[[_tabView selectedTabViewItem] label]  isEqual: @"Tabs"]) {
        [_window makeFirstResponder:_tabsView];
    }
    else if ([[[_tabView selectedTabViewItem] label]  isEqual: @"Notes"]) {
        [_window makeFirstResponder:_notesView];
    }
    else if ([[[_tabView selectedTabViewItem] label]  isEqual: @"Song"]) {
        [_window makeFirstResponder:_songName];
    }
}

#pragma mark -
#pragma mark Song methods

- (IBAction)addSong:(id)sender {
    [_songArray add:self];
    [self changeTab:0];
    [_window makeFirstResponder:_songName];
}

#pragma mark -
#pragma mark Table View Delagte methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_songArray.arrangedObjects count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
        return cellView;
    }
    
    return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    NSInteger selectedRows = [_songView numberOfSelectedRows];
    
    if (selectedRows > 0) {
        [_tabControl setHidden:NO];
        [_tabView setHidden:NO];
        [_noSongSelected setHidden:YES];
        
        NSImage *artwork = [_artworkView image];
        NSString *artworkName = [artwork name];
        if (artwork == nil ||  [artworkName  isEqual: @"Music Note"]) {
           [_artworkView setImage:[NSImage imageNamed:@"Drag and Drop Artwork"]];
        }
    }
    else {
        [_tabControl setHidden:YES];
        [_tabView setHidden:YES];
        [_noSongSelected setHidden:NO];
    }
}

- (void)tableView:(NSTableView *)tableView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row {
    NSImage *artwork = [_artworkView image];
    if (artwork == nil || [[artwork name]  isEqual: @"Music Note"]) {
        [_artworkView setImage:[NSImage imageNamed:@"Drag and Drop Artwork"]];
    }
    
    
}

@end
