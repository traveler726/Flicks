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
#import "MovieDetailViewController.h"
#import "MoviePosterCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView

@interface ViewController () <UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>;

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@property (strong, nonatomic) NSArray<MovieModel *> *movies;

@property (strong, nonatomic) NSString *movieApiPath;

@property (strong, nonatomic) UICollectionView *collectionView; // Strong manages the destruction better!
// CollectionView supports dynamic layout that is flexible.  Going to use defaultLayout now - but can do customLayout.

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
    
    // Good place to setup your views here in this method.  View has loaded and good place to add subviews.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat itemHeigth = 150;
    CGFloat itemWidth  = screenWidth / 3;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeigth);  // Setting a static size of the layout.
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 64) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor magentaColor];
    collectionView.hidden = YES;  // start in the hidden state so the tableView by the storyboard shows up and not this GRID!
    //self.movieTableView.hidden = YES;
    [collectionView registerClass:[MoviePosterCollectionViewCell class] forCellWithReuseIdentifier:@"MoviePosterCollectionViewCell"];
    collectionView.dataSource = self;
    collectionView.delegate   = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [self fetchMovies];
}

- (void) fetchMovies {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    
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

#pragma mark - UICollectionViewDataSource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // We need the cell
    MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoviePosterCollectionViewCell" forIndexPath:indexPath];
    MovieModel *model = [self.movies objectAtIndex:indexPath.item];
    cell.model = model;
    [cell reloadData];
    
    return cell;
}


// Moving the reload of the data into a separate method so can push to the main thread.
- (void) reloadTheData {
    [self.movieTableView reloadData];
    [self.collectionView reloadData];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showMovieDetailsControllerSeque"] ) {
        
        MovieDetailViewController *destViewController = [segue destinationViewController];
        // Two ways to convert sender to a row index --> one puts extra pointer on heap.
        //MovieTableViewCell *tableCell = (MovieTableViewCell *)sender;
        //NSIndexPath *indexPath = [self.movieTableView indexPathForCell:tableCell];
        NSIndexPath *indexPath = [self.movieTableView indexPathForCell:((UITableViewCell *) sender)];
        destViewController.movieModel = [self.movies objectAtIndex:indexPath.row];
        
    }
}

@end
