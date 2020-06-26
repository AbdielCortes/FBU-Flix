//
//  DetailsViewController.m
//  Flix
//
//  Created by zurken on 6/25/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *moviePremiereDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieRating;

@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    NSString *backdropURLString = [baseURLString stringByAppendingString:self.movie[@"backdrop_path"]];
    NSURL *backdropURL = [NSURL URLWithString:backdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    NSString *posterURLString = [baseURLString stringByAppendingString:self.movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    self.movieTitleLabel.text = self.movie[@"title"];
    [self.movieTitleLabel sizeToFit];
    
    self.moviePremiereDateLabel.text = self.movie[@"release_date"];
    
    double voteAverage = [self.movie[@"vote_average"] doubleValue];
    self.movieRating.text = [NSString stringWithFormat:@"Rated %.1f/10", voteAverage];
    
    self.movieDescriptionLabel.text = self.movie[@"overview"];
    [self.movieDescriptionLabel sizeToFit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
