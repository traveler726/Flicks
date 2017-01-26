//
//  MoviePosterCollectionViewCell.m
//  Flicks
//
//  Created by Jennifer Beck on 1/26/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "MoviePosterCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView

@interface MoviePosterCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MoviePosterCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView]; // Doesn't get strong reference  until now or line below.
        self.imageView = imageView;
    }
    return self;
}

- (void) reloadData {
    [self.imageView setImageWithURL:self.model.posterURL];
    [self setNeedsLayout];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}
@end
