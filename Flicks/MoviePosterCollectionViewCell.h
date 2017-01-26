//
//  MoviePosterCollectionViewCell.h
//  Flicks
//
//  Created by Jennifer Beck on 1/26/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MoviePosterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MovieModel *model;

- (void) reloadData;

@end
