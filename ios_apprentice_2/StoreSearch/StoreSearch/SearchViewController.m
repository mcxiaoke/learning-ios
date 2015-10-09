//
//  SearchViewController.m
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/9.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "SearchViewController.h"
#import "SearchResult.h"
#import "SearchResultCell.h"
#import "DetailViewController.h"

static NSString *const SEARCH_RESULT_CELL_IDENTIFIER = @"SearchResultCell";
static NSString *const NOTHING_FOUND_CELL_IDENTIFIER = @"NothingFoundCell";
static NSString *const LOADING_CELL_IDENTIFIER = @"LoadingCell";

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate,
                                   UISearchBarDelegate>
@property(weak, nonatomic) IBOutlet UISegmentedControl *segementdControl;
@property(weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *searchResults;
@property(strong, nonatomic) NSOperationQueue *queue;
@property BOOL isLoading;

@end

@implementation SearchViewController

- (IBAction)segementChanged:(UISegmentedControl *)sender {
  NSLog(@"Segment changed: %lu", sender.selectedSegmentIndex);
  if (self.searchResults) {
    [self doSearch];
  }
}

- (NSOperationQueue *)queue {
  if (!_queue) {
    _queue = [[NSOperationQueue alloc] init];
  }
  return _queue;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.contentInset = UIEdgeInsetsMake(108, 0, 0, 0);
  //    self.tableView.rowHeight=80;
  UINib *cellLib =
      [UINib nibWithNibName:SEARCH_RESULT_CELL_IDENTIFIER bundle:nil];
  [self.tableView registerNib:cellLib
       forCellReuseIdentifier:SEARCH_RESULT_CELL_IDENTIFIER];

  cellLib = [UINib nibWithNibName:NOTHING_FOUND_CELL_IDENTIFIER bundle:nil];
  [self.tableView registerNib:cellLib
       forCellReuseIdentifier:NOTHING_FOUND_CELL_IDENTIFIER];

  cellLib = [UINib nibWithNibName:LOADING_CELL_IDENTIFIER bundle:nil];
  [self.tableView registerNib:cellLib
       forCellReuseIdentifier:LOADING_CELL_IDENTIFIER];
  [self.searchBar becomeFirstResponder];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (self.isLoading) {
    return 1;
  } else if (!self.searchResults) {
    return 0;
  } else if ([self.searchResults count] == 0) {
    return 1;
  } else {
    return [self.searchResults count];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.isLoading) {
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:LOADING_CELL_IDENTIFIER
                                        forIndexPath:indexPath];
    UIActivityIndicatorView *spinner =
        (UIActivityIndicatorView *)[cell viewWithTag:100];
    [spinner startAnimating];
    return cell;
  } else if ([self.searchResults count] == 0) {
    return [tableView
        dequeueReusableCellWithIdentifier:NOTHING_FOUND_CELL_IDENTIFIER
                             forIndexPath:indexPath];
  } else {
    SearchResultCell *cell = [tableView
        dequeueReusableCellWithIdentifier:SEARCH_RESULT_CELL_IDENTIFIER
                             forIndexPath:indexPath];
    SearchResult *result = self.searchResults[indexPath.row];
    [cell configureForSearchResult:result];

    return cell;
  }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.searchBar resignFirstResponder];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  DetailViewController *controller =
      [[DetailViewController alloc] initWithNibName:@"DetailViewController"
                                             bundle:nil];

  SearchResult *searchResult = self.searchResults[indexPath.row];
  controller.searchResult = searchResult;
  [controller presentInParentViewController:self];
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.isLoading || [self.searchResults count] == 0) {
    return nil;
  } else {
    return indexPath;
  }
}

- (void)doSearch {
  if ([self.searchBar.text length] == 0) {
    return;
  }
  [self.searchBar resignFirstResponder];
  if (!self.searchResults) {
    self.searchResults = [[NSMutableArray alloc] init];
  }
  [self.searchResults removeAllObjects];
  self.isLoading = YES;
  [self.tableView reloadData];

  [self.queue cancelAllOperations];
  NSLog(@"Start!");
  NSURL *url =
      [self urlWithSearchText:self.searchBar.text
                     category:self.segementdControl.selectedSegmentIndex];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFJSONResponseSerializer serializer];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_Nonnull
                                                 operation,
                                             id _Nonnull responseObject) {
    NSLog(@"Sucess!");
    [self parseDict:responseObject];
    [self.searchResults sortUsingSelector:@selector(compareName:)];
    self.isLoading = NO;
    [self.tableView reloadData];
  } failure:^(AFHTTPRequestOperation *_Nonnull operation,
              NSError *_Nonnull error) {
    if (operation.isCancelled) {
      return;
    }
    NSLog(@"Failure! %@", error);
    [self handleNetworkError];
  }];
  [self.queue addOperation:operation];
}

#pragma mark - search bar delegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  return UIBarPositionTopAttached;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [self doSearch];
}

- (void)handleNetworkError {
  self.isLoading = NO;
  [self.tableView reloadData];
  [self showNetworkError];
}

- (NSURL *)urlWithSearchText:(NSString *)searchText
                    category:(NSInteger)category {
  NSString *categoryName;
  switch (category) {
    case 0:
      categoryName = @"";
      break;
    case 1:
      categoryName = @"musicTrack";
      break;
    case 2:
      categoryName = @"software";
      break;
    case 3:
      categoryName = @"ebook";
      break;
  }
  NSString *escapedSearchText = [searchText
      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSString *urlString = [NSString
      stringWithFormat:
          @"http://itunes.apple.com/search?term=%@&limit=200&entity=%@",
          escapedSearchText, categoryName];
  NSURL *url = [NSURL URLWithString:urlString];
  return url;
}

- (NSString *)performStoreRequestWithURL:(NSURL *)url {
  NSError *error;
  NSString *resultString =
      [NSString stringWithContentsOfURL:url
                               encoding:NSUTF8StringEncoding
                                  error:&error];
  if (!resultString) {
    NSLog(@"Request Error: %@", error);
    return nil;
  }
  return resultString;
}

- (NSDictionary *)parseJSON:(NSString *)jsonString {
  NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error;
  id resultObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions
                                                      error:&error];
  if (![resultObject isKindOfClass:[NSDictionary class]]) {
    NSLog(@"JSON Error: %@", error);
    return nil;
  }
  return resultObject;
}

- (void)parseDict:(NSDictionary *)dict {
  NSArray *array = dict[@"results"];
  if (!array) {
    NSLog(@"Expected 'results' array");
    return;
  }
  for (NSDictionary *resultDict in array) {
    SearchResult *searchResult;
    NSString *wrapperType = resultDict[@"wrapperType"];
    NSString *kind = resultDict[@"kind"];
    NSLog(@"parse dict, type: %@", wrapperType);
    if ([wrapperType isEqualToString:@"track"]) {
      searchResult = [self parseTrack:resultDict];
    } else if ([wrapperType isEqualToString:@"audiobook"]) {
      searchResult = [self parseAudioBook:resultDict];
    } else if ([wrapperType isEqualToString:@"software"]) {
      searchResult = [self parseSoftware:resultDict];
    } else if ([kind isEqualToString:@"ebook"]) {
      searchResult = [self parseEBook:resultDict];
    }
    if (searchResult) {
      [self.searchResults addObject:searchResult];
    }
  }
}

- (SearchResult *)parseTrack:(NSDictionary *)dict {
  SearchResult *sr = [[SearchResult alloc] init];
  sr.name = dict[@"trackName"];
  sr.artistName = dict[@"artistName"];
  sr.artworkURL60 = dict[@"artworkUrl60"];
  sr.artworkURL100 = dict[@"artworkUrl100"];
  sr.storeURL = dict[@"trackViewUrl"];
  sr.kind = dict[@"kind"];
  sr.price = dict[@"trackPrice"];
  sr.currency = dict[@"currency"];
  sr.genre = dict[@"primaryGenreName"];
  return sr;
}

- (SearchResult *)parseAudioBook:(NSDictionary *)dictionary {
  SearchResult *searchResult = [[SearchResult alloc] init];
  searchResult.name = dictionary[@"collectionName"];
  searchResult.artistName = dictionary[@"artistName"];
  searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
  searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
  searchResult.storeURL = dictionary[@"collectionViewUrl"];
  searchResult.kind = @"audiobook";
  searchResult.price = dictionary[@"collectionPrice"];
  searchResult.currency = dictionary[@"currency"];
  searchResult.genre = dictionary[@"primaryGenreName"];
  return searchResult;
}

- (SearchResult *)parseSoftware:(NSDictionary *)dictionary {
  SearchResult *searchResult = [[SearchResult alloc] init];
  searchResult.name = dictionary[@"trackName"];
  searchResult.artistName = dictionary[@"artistName"];
  searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
  searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
  searchResult.storeURL = dictionary[@"trackViewUrl"];
  searchResult.kind = dictionary[@"kind"];
  searchResult.price = dictionary[@"price"];
  searchResult.currency = dictionary[@"currency"];
  searchResult.genre = dictionary[@"primaryGenreName"];
  return searchResult;
}
- (SearchResult *)parseEBook:(NSDictionary *)dictionary {
  SearchResult *searchResult = [[SearchResult alloc] init];
  searchResult.name = dictionary[@"trackName"];
  searchResult.artistName = dictionary[@"artistName"];
  searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
  searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
  searchResult.storeURL = dictionary[@"trackViewUrl"];
  searchResult.kind = dictionary[@"kind"];
  searchResult.price = dictionary[@"price"];
  searchResult.currency = dictionary[@"currency"];
  searchResult.genre =
      [(NSArray *)dictionary[@"genres"] componentsJoinedByString:@", "];
  return searchResult;
}

- (void)showNetworkError {
  UIAlertView *alertView =
      [[UIAlertView alloc] initWithTitle:@"Oooops..."
                                 message:@"There was an error reading from "
                                 @"iTunes Store.Please try again."
                                delegate:nil
                       cancelButtonTitle:@"Ok"
                       otherButtonTitles:nil];
  [alertView show];
}

@end
