//
//  MasterViewController.m
//  ScaryBugsMac
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Quartz/Quartz.h>
#import "NSImage+Extras.h"
#import "MasterViewController.h"
#import "ScaryBugData.h"
#import "ScaryBugDoc.h"
#import "EDStarRating.h"

@interface MasterViewController () <NSTableViewDataSource, NSTableViewDelegate, EDStarRatingProtocol>
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *titleView;
@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet EDStarRating *ratingView;
@property (weak) IBOutlet NSButton *deleteButton;
@property (weak) IBOutlet NSButton *changePictureButton;

@end

@implementation MasterViewController

-(void)loadView{
  [super loadView];
  [self configureRatingView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

-(void)configureRatingView{
  self.ratingView.starImage = [NSImage imageNamed:@"star.png"];
  self.ratingView.starHighlightedImage = [NSImage imageNamed:@"shockedface2_full.png"];
  self.ratingView.starImage = [NSImage imageNamed:@"shockedface2_empty.png"];
  self.ratingView.maxRating = 5.0;
  self.ratingView.delegate = (id<EDStarRatingProtocol>) self;
  self.ratingView.horizontalMargin = 12;
  self.ratingView.editable=NO;
  self.ratingView.displayMode=EDStarRatingDisplayFull;
  
  
  self.ratingView.rating= 0.0;
}

- (IBAction)titleDidEndEdit:(id)sender {
  ScaryBugDoc* selectedDoc = [self selectedBugDoc];
  if (selectedDoc) {
    selectedDoc.data.title = self.titleView.stringValue;
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:[self.bugs indexOfObject:selectedDoc]];
    NSIndexSet* columnSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
  }
}

-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating{
  ScaryBugDoc *selectedDoc = [self selectedBugDoc];
  if( selectedDoc )
  {
    selectedDoc.data.rating = self.ratingView.rating;
  }
}

- (IBAction)changePicture:(id)sender {
  ScaryBugDoc* selectedDoc = [self selectedBugDoc];
  if (selectedDoc) {
    [[IKPictureTaker pictureTaker] beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
  }
}

- (void) pictureTakerDidEnd:(IKPictureTaker *) picker
                 returnCode:(NSInteger) code
                contextInfo:(void*) contextInfo
{
  NSLog(@"pictureTakerDidEnd");
  NSImage* image = [picker outputImage];
  if (image && code  == NSOKButton) {
    self.imageView.image = image;
    ScaryBugDoc* selectedDoc = [self selectedBugDoc];
    if (selectedDoc) {
      selectedDoc.fullImage = image;
      selectedDoc.thumbImage = [image imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
      NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:[self.bugs indexOfObject:selectedDoc]];
      NSIndexSet* columnSet = [NSIndexSet indexSetWithIndex:0];
      [self.tableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
  }
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
  NSTableCellView* cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
  
  if ([tableColumn.identifier isEqualToString:@"BugColumn"]) {
    ScaryBugDoc* bugDoc = self.bugs[row];
    cellView.imageView.image = bugDoc.thumbImage;
    cellView.textField.stringValue = bugDoc.data.title;
    return cellView;
  }
  return cellView;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
  return self.bugs.count;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification{
  ScaryBugDoc* selectedDoc = [self selectedBugDoc];
  [self setDetailInfo:selectedDoc];
  BOOL buttonEnabled = (selectedDoc!=nil);
  self.deleteButton.enabled = buttonEnabled;
  self.changePictureButton.enabled = buttonEnabled;
  self.ratingView.editable = buttonEnabled;
  self.titleView.enabled = buttonEnabled;
}

-(ScaryBugDoc*)selectedBugDoc{
  NSInteger selectedRow = self.tableView.selectedRow;
  if (selectedRow>=0 && self.bugs.count > selectedRow) {
    ScaryBugDoc* selectedBug = self.bugs[selectedRow];
    return selectedBug;
  }
  return nil;
}

-(void)setDetailInfo:(ScaryBugDoc*)doc{
  NSString* title = @"";
  NSImage* image = nil;
  float rating = 0.0;
  if (doc!=nil) {
    title = doc.data.title;
    image = doc.fullImage;
    rating = doc.data.rating;
  }
  
  self.titleView.stringValue = title;
  self.imageView.image = image;
  self.ratingView.rating = rating;

}

- (IBAction)addBug:(id)sender {
  ScaryBugDoc* newDoc = [[ScaryBugDoc alloc] initWithTitle:@"New Bug" rating:0.0
                                                thumbImage:nil fullImage:nil];
  [self.bugs addObject:newDoc];
  NSInteger newRowIndex = self.bugs.count-1;
  [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex]
                        withAnimation:NSTableViewAnimationEffectGap];
  [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
  [self.tableView scrollRowToVisible:newRowIndex];
}


- (IBAction)removeBug:(id)sender {
  ScaryBugDoc* selectedDoc = [self selectedBugDoc];
  if (selectedDoc) {
    [self.bugs removeObject:selectedDoc];
    [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.tableView.selectedRow]
                          withAnimation:NSTableViewAnimationSlideRight];
    [self setDetailInfo:nil];
  }
}






@end
