//
//  Movie.m
//  Flix
//
//  Created by zurken on 7/1/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.title = dictionary[@"title"];
    self.description = dictionary[@"overview"];
    self.releaseDate = dictionary[@"release_date"];
    self.rating = dictionary[@"vote_average"];
    
    self.posterUrlString = dictionary[@"poster_path"];
    self.backdropUrlString = dictionary[@"backdrop_path"];
    
    return self;
}

// creates an array of Movies from an array of dictionaries
+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *movies;

    for (NSDictionary *movieDictionary in dictionaries) {
        [movies addObject:[[Movie init] initWithDictionary:movieDictionary]];
    }
    
    //NSArray *result = [movies copy];
    return movies;
}


@end
