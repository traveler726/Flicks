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
    
    // Configure/Setup the embedded scrollView now
    [self setupScrollView];
    
    NSLog(@"Restoration ID: %@", self.restorationIdentifier);
    [self fetchMovieDetails];
}

// Configure the embedded scrollView now
- (void) setupScrollView {
    NSInteger width = self.scrollView.bounds.size.width;
    NSInteger height = self.scrollView.bounds.size.height * 3;
    self.scrollView.contentSize = CGSizeMake(width,height);
    

    // Now setup the sub-view "container"
    //  * background color.
    //  * height based on the scrollView height.
    
    // Setting the background color:
    //    Option 1
    //      UIColor *bckgrndColor = [UIColor colorWithHue:60 saturation:0.2 brightness:1.0 alpha:1.0];
    //      self.scrollableView.backgroundColor = bckgrndColor;
    //    Option 2
    //      self.scrollableView.backgroundColor = [UIColor lightGrayColor];
    // self.scrollableView.backgroundColor = [UIColor lightGrayColor];
    
    // Setup the sizing of the sub scrollable view now
    CGRect newFrame = self.scrollableView.frame;
    newFrame.size.width  = self.scrollView.bounds.size.width;
    newFrame.size.height = self.scrollView.bounds.size.height*3;
    [self.scrollableView setFrame:newFrame];
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
