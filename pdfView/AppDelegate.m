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
    if ([[sender title]isEqual:@"Next"]) {
        [_pdfView goToNextPage:nil];
    }
    if ([[sender title] isEqual:@"Preview"]) {
        [_pdfView goToPreviousPage:nil];
    }
    if ([[sender title] isEqual:@"Find"]) {
        NSArray *myFind = [_myDoc findString:@"Share" withOptions:0];
        [_pdfView setCurrentSelection:myFind[0]];
        [_pdfView scrollSelectionToVisible:nil];
    }
}

- (IBAction)find:(id)sender {
    [_textFindCell setSearchMenuTemplate:_searchMenu];
    NSString *searchString = [_textFind stringValue];
    NSArray *myFind = [_myDoc findString:searchString withOptions:0];
    [_pdfView setCurrentSelection:myFind[0]];
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
@end
