//
//  AppDelegate.h
//  pdfView
//
//  Created by Александр Кузнецов on 16.05.16.
//  Copyright (c) 2016 Александр Кузнецов. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> 

@property (weak) IBOutlet NSTextFinder *textFinder;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet PDFView *pdfView;
@property NSURL *theDoc;
@property PDFDocument *myDoc;
@property (weak) IBOutlet NSSearchField *textFind;
@property (weak) IBOutlet NSSearchFieldCell *textFindCell;
@property (weak) IBOutlet NSMenu *searchMenu;
@property (weak) IBOutlet NSPopUpButton *popUp;


- (IBAction)addButton:(id)sender;
- (IBAction)navigate:(id)sender;
- (IBAction)find:(id)sender;
- (IBAction)viewStyle:(id)sender;



@end
