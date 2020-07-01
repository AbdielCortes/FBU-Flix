//
//  MovieCollectionCell.m
//  Flix
//
//  Created by zurken on 6/26/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCollectionCell

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = [baseURLString stringByAppendingString:movie.posterUrlString];
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    self.moviePosterView.image = nil;
    [self.moviePosterView setImageWithURL:posterURL];
}

@end
