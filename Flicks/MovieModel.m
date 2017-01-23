//
//  MovieModel.m
//  Flicks
//
//  Created by Jennifer Beck on 1/23/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

- (instancetype) initWithDictionary: (NSDictionary *) dictionary {

    self = [super init];
    
    if (self) {  // Verify that it exists.
        
        // Initial the model by parsing the JSON Dictionary
        self.title = dictionary[@"original_title"];
        self.movieDescription = dictionary[@"overview"];
        
        // Build the image path from the poster path and API:
        // The movie poster is available by appending the returned poster_path to https://image.tmdb.org/t/p/w342.
        
        // Too Much Memory trashing...
        // NSString *urlPath   = dictionary[@"poster_path"]; // path only!
        // NSString *urlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", urlPath];
        
        
        NSString *urlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", dictionary[@"poster_path"]];
        self.posterURL = [NSURL URLWithString:urlString];
        
        
    }
    
    return self;
}

@end
