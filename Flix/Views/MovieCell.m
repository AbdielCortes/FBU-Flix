//
//  MovieCell.m
//  Flix
//
//  Created by zurken on 6/25/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    
    self.movieTitleLabel.text = movie.title;
    self.movieDescriptionLabel.text = movie.descriptionText;
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = [baseURLString stringByAppendingString:movie.posterUrlString];
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    self.moviePosterView.image = nil;
    [self.moviePosterView setImageWithURL:posterURL];
}

@end
