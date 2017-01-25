//
//  ViewController.m
//  Flicks
//
//  Created by Jennifer Beck on 1/23/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "ViewController.h"
#import "MovieTableViewCell.h"
#import "MovieModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView

@interface ViewController () <UITableViewDataSource>;

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@property (strong, nonatomic) NSArray<MovieModel *> *movies;

@property (strong, nonatomic) NSString *movieApiPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.movieTableView.dataSource = self;    //if ([self.restorationIdentifier]
    if (self.restorationIdentifier) {
        self.movieApiPath = self.restorationIdentifier;
    } else {
        self.movieApiPath = @"popular";
        self.movieApiPath = self.restorationIdentifier;
    }
    NSLog(@"Restoration ID: %@ and MovieAPIPath: %@", self.restorationIdentifier, self.movieApiPath);
    [self fetchMovies];
}

- (void) fetchMovies {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
//    NSString *urlString = [@"https://api.themoviedb.org/3/movie/now_playing?api_key=" stringByAppendingString:apiKey];
    
    NSString *movieApiURL = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@", self.movieApiPath, apiKey];
    NSLog(@"\tUsing Moving API URL: %@", movieApiURL);
    
    NSURL *url = [NSURL URLWithString:movieApiURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];  // Delegation to the mainQueue will guarentee it is on the main thread.
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    
                                                    // Parse the dictionary 'results' array into individual movie json maps.
                                                    // Then populate the movie models from each movie json map.
                                                    NSArray *results = responseDictionary[@"results"];
                                                    
                                                    NSMutableArray *models = [NSMutableArray array];
                                                    for (NSDictionary *result in results) {
                                                        MovieModel *model = [[MovieModel alloc] initWithDictionary:result];
                                                        NSLog(@"Model = %@", model);
                                                        [models addObject:model];
                                                    }
                                                    // Since ViewController is defined as non-mutable the access to it will be non-mutable.
                                                    // This is true even tho the backing object is actually a mutable array.
                                                    self.movies = models;
                                                    
                                                    // force the tableView new info to display
                                                    [self performSelectorOnMainThread:@selector(reloadTheData) withObject:(nil) waitUntilDone:(NO)];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

// Moving the reload of the data into a separate method so can push to the main thread.
- (void) reloadTheData {
    [self.movieTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"movieCell"];
    
    MovieTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
//  [cell.titleLabel setText:[NSString stringWithFormat:@"Row %ld", indexPath.row]];
//  [cell.overviewLabel setText:[NSString stringWithFormat:@"Overview for row %ld", indexPath.row]];
//  [cell.posterImage setImage:[UIImage imageNamed:@"poster_placeholder.png"]];
    
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.title;
    cell.overviewLabel.text = model.movieDescription;
//  cell.posterImage.contentMode = UIViewContentModeScaleAspectFit;  // can also set in the storyboard view.
    [cell.posterImage setImageWithURL:model.posterURL];
    
    NSLog(@"Loading Row:$%ld", indexPath.row);

    return cell;
}

- (NSInteger)tableView:(UITableView *)movieTableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

@end
