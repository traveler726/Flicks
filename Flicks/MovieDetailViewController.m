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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self fetchMovieDetails];

    // Configure/Setup the embedded scrollView now
    [self setupScrollView];
    
    NSLog(@"Restoration ID: %@", self.restorationIdentifier);
}

// Configure the embedded scrollView now
- (void) setupScrollView {
    
    // Step 1 - resize the overview label based on the text size.
    [self.overviewView sizeToFit];

    // Step 2 - figure out the size of the scrollable item view container
    //          Get is the size of the overview
    //          Add this to the title to get the size of the stuff in the scrollable
    //          Best way is to get the max y of the overview which is relative
    //            the view it is contained within.
    CGFloat maxOverviewY = CGRectGetMaxY(self.overviewView.frame);
    CGFloat maxTitleY    = CGRectGetMaxY(self.titleView.frame);
    
    // Step 3 - set the frame size of the scrollable item view container (or the card in the ScrollView)
    CGRect scrollableViewFrame = self.scrollableView.frame;
    scrollableViewFrame.size.height = maxOverviewY;
    
    // Step 4 - set the frame starting position relative to the container offset!
    scrollableViewFrame.origin.y = scrollableViewFrame.size.height - maxTitleY;
    self.scrollableView.frame    = scrollableViewFrame;
    
    // Step 5 - Set the scrollView contentSize based on the scrollable itemview within.
    NSInteger width  = self.scrollView.bounds.size.width;
    NSInteger height = scrollableViewFrame.origin.y + maxOverviewY;
    self.scrollView.contentSize = CGSizeMake(width,height);
    
    // Step 6 - Set the frame of the scrollview as well!
    CGRect scrollViewframe = self.scrollView.frame;
    scrollViewframe.size.height = maxOverviewY + 20;
    scrollViewframe.origin.y = self.view.bounds.size.height - scrollViewframe.size.height - 10;
    self.scrollView.frame = scrollViewframe;
    
    // Debugging help here - will comment out later.
//    self.scrollView.layer.borderColor = [UIColor orangeColor].CGColor;
//    self.scrollView.layer.borderWidth = 2;
}

- (void) fetchMovieDetails {
    NSLog (@"TBD - fetch the movie details here");
    if (self.movieModel) {
        NSLog (@"Detail called with movie: %@", self.movieModel);
        self.titleView.text    = self.movieModel.title;
        self.overviewView.text = self.movieModel.movieDescription;
        [self.overviewView sizeToFit];
        [self.posterImageView setImageWithURL:self.movieModel.posterURL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
