//
//  MovieModel.h
//  Flicks
//
//  Created by Jennifer Beck on 1/23/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

- (instancetype) initWithDictionary: (NSDictionary *) otherDictionary;

// Creating properties is best-practice .vs. instance.
// properties allocate memory for field as well as getter/setters dynamically!
// Instance Example: NSString *title;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSURL    *posterURL;

@end
