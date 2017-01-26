//
//  MovieDetailViewController.m
//  Flicks
//
//  Created by Jennifer Beck on 1/23/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieTableViewCell.h"
#import "MovieModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView

@interface MovieDetailViewController () ;

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView; // Actual ScrollView object.
@property (weak, nonatomic) IBOutlet UIView *scrollableView;   // Scrollable View container inside scrollView
@property (weak, nonatomic) IBOutlet UILabel *titleView;       // Inside scrollableView container
@property (weak, nonatomic) IBOutlet UILabel *overviewView;    // Inside scrollableView container

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Restoration ID: %@", self.restorationIdentifier);
    [self fetchMovieDetails];
}

- (void) fetchMovieDetails {
    NSLog (@"TBD - fetch the movie details here");
    if (self.movieModel) {
        NSLog (@"Detail called with movie: %@", self.movieModel);
        self.titleView.text    = self.movieModel.title;
        self.overviewView.text = self.movieModel.movieDescription;
        [self.posterImageView setImageWithURL:self.movieModel.posterURL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
