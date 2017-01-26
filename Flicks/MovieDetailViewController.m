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
    
    // Step 3 - set the frame size of the scrollable item view container
    CGRect scrollableViewFrame = self.scrollableView.frame;
    scrollableViewFrame.size.height = maxOverviewY + 5;
    
    // Step 4 - set the frame starting position relative to the container offset!
    CGFloat maxTitleY = CGRectGetMaxY(self.titleView.frame) + 20;
    scrollableViewFrame.origin.y = maxTitleY; // 100;
    
    // TBD - is this needed to hand it back or is it really the view's frame you are modifying?
    [self.scrollableView setFrame:scrollableViewFrame];
    
    // Step 5 - Set the scrollView contentSize based on the scrollable itemview within.
    NSInteger width  = self.scrollView.bounds.size.width;
    NSInteger height = maxOverviewY + 20; // self.scrollView.bounds.size.height * 3;
    self.scrollView.contentSize = CGSizeMake(width,height);
    
    // Step 6 - Set the frame of the scrollview as well!
    CGRect scrollViewframe = self.scrollView.frame;
    scrollViewframe.size.height = maxOverviewY + 5;
    
    // Debugging help here - will comment out later.
    
    self.scrollView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.scrollView.layer.borderWidth = 2;

//    // Now setup the sub-view "container"
//    //  * background color.
//    //  * height based on the scrollView height.
//    
//    // Setting the background color:
//    //    Option 1
//    //      UIColor *bckgrndColor = [UIColor colorWithHue:60 saturation:0.2 brightness:1.0 alpha:1.0];
//    //      self.scrollableView.backgroundColor = bckgrndColor;
//    //    Option 2
//    //      self.scrollableView.backgroundColor = [UIColor lightGrayColor];
//    // self.scrollableView.backgroundColor = [UIColor lightGrayColor];
//    
//    // Setup the sizing of the sub scrollable view now
//    CGRect newFrame = self.scrollableView.frame;
//    newFrame.origin.y = 100;
//    [self.scrollableView setFrame:newFrame];
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
