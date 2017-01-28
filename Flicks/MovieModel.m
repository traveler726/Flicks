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
        
        //id rd = dictionary[@"release_date"];
        
        [self setReleaseDateFromString:dictionary[@"release_date"]];
        
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

- (void) setReleaseDateFromString:(NSString *) dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate *releaseDate = [dateFormatter dateFromString:releaseDateStr];
    self.releaseDate = [dateFormatter dateFromString:dateString];
    NSLog(@"TItle: %@ Release Date: %@", self.title, [self releaseDateAsString]);
}

- (NSString *) releaseDateAsString {
    // Format: MMMM d, yyyy ==> January 27, 2017
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:self.releaseDate];
    return strDate;
}

@end
