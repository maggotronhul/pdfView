//
//  AppDelegate.m
//  pdfView
//
//  Created by Александр Кузнецов on 16.05.16.
//  Copyright (c) 2016 Александр Кузнецов. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_popUp insertItemWithTitle:@"Single Page" atIndex:0];
    [_popUp insertItemWithTitle:@"Single Page Continuous" atIndex:1];
    [_popUp insertItemWithTitle:@"Two Uo" atIndex:2];
    [_popUp insertItemWithTitle:@"Two Up Continuous" atIndex:3];
    [_pdfView setDisplayMode:0];
    _i = 0;
    _toolBar.allowsUserCustomization = NO;
    
    // Insert code here to initialize your application
}


- (IBAction)addButton:(id)sender {
    NSOpenPanel *mop = [NSOpenPanel openPanel];
    [mop beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            _theDoc = [[mop URLs] objectAtIndex:0];
            
            _myDoc = [[PDFDocument alloc] initWithURL:_theDoc];
            [_pdfView setDocument:_myDoc];
        }
        
    }];
    
    NSMenuItem *item;
    
    item = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Clear", @"Clear menu title")
                                      action:NULL keyEquivalent:@""];
    [item setTag:NSSearchFieldClearRecentsMenuItemTag];
    [_searchMenu insertItem:item atIndex:0];
    
    
    item = [NSMenuItem separatorItem];
    [item setTag:NSSearchFieldRecentsTitleMenuItemTag];
    [_searchMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Recent Searches", @"Recent Searches menu title")
                                      action:NULL keyEquivalent:@""];
    [item setTag:NSSearchFieldRecentsTitleMenuItemTag];
    [_searchMenu insertItem:item atIndex:2];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Recents"
                                      action:NULL keyEquivalent:@""];
    [item setTag:NSSearchFieldRecentsMenuItemTag];
    [_searchMenu insertItem:item atIndex:3];
    
    item = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"No recent searches", @"No recent searches menu item")
                                      action:NULL keyEquivalent:@""];
    [item setTag:NSSearchFieldNoRecentsMenuItemTag];
    [_searchMenu insertItem:item atIndex:4];
    
    [_textFindCell setSearchMenuTemplate:_searchMenu];
    
    
}

- (IBAction)navigate:(id)sender {
    if ([sender isSelectedForSegment:1]) {
        [_pdfView goToNextPage:nil];
    }
    if ([sender isSelectedForSegment:0]) {
        [_pdfView goToPreviousPage:nil];
    }
}

- (IBAction)find:(id)sender {
    [_textFindCell setSearchMenuTemplate:_searchMenu];
    NSString *searchString = [_textFind stringValue];
    _myFind = NULL;
    _myFind = [_myDoc findString:searchString withOptions:NSCaseInsensitiveSearch];
    [_pdfView setCurrentSelection:_myFind[0]];
    [_pdfView scrollSelectionToVisible:nil];
}

- (IBAction)viewStyle:(id)sender {
    if ([[sender titleOfSelectedItem] isEqual:@"Single Page"]) {
        [_pdfView setDisplayMode:0];
    }
    if ([[sender titleOfSelectedItem] isEqual:@"Single Page Continuous"]) {
        [_pdfView setDisplayMode:1];
    }
    if ([[sender titleOfSelectedItem] isEqual:@"Two Uo"]) {
        [_pdfView setDisplayMode:2];
    }
    if ([[sender titleOfSelectedItem] isEqual:@"Two Up Continuous"]) {
        [_pdfView setDisplayMode:3];
    }
}

- (IBAction)findMenu:(id)sender {
    [_textFind selectText:nil];
    if ([sender isSelectedForSegment:1]/*||[[sender title] isEqualToString:@"Find Next"]*/) {
        if (_i<[_myFind count]) {
        [_pdfView setCurrentSelection:_myFind[++_i]];
        [_pdfView scrollSelectionToVisible:nil];
        }
    }
    if ([sender isSelectedForSegment:0]/*||[[sender title] isEqualToString:@"Find Previous"]*/) {
        if (_i) {
        [_pdfView setCurrentSelection:_myFind[--_i]];
        [_pdfView scrollSelectionToVisible:nil];
        }
    }
}

- (IBAction)findMenuItem:(id)sender {
    if ([[sender title] isEqualToString:@"Find Next"]) {
        if (_i<[_myFind count]) {
            [_pdfView setCurrentSelection:_myFind[++_i]];
            [_pdfView scrollSelectionToVisible:nil];
        }
    }
    if ([[sender title] isEqualToString:@"Find Previous"]) {
        if (_i) {
            [_pdfView setCurrentSelection:_myFind[--_i]];
            [_pdfView scrollSelectionToVisible:nil];
        }
    }
}
@end
