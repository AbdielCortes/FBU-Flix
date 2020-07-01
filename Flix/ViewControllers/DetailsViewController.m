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
    
    NSString *rawDate = self.movie[@"release_date"];
    self.moviePremiereDateLabel.text = [self dateConverter:rawDate];
    
    double voteAverage = [self.movie[@"vote_average"] doubleValue];
    self.movieRating.text = [NSString stringWithFormat:@"Rated %.1f/10", voteAverage];
    
    self.movieDescriptionLabel.text = self.movie[@"overview"];
    [self.movieDescriptionLabel sizeToFit];
}

// converts yyyy-mm-dd into Month day, year
- (NSString *)dateConverter:(NSString *) unformatedDate {
    // converts number to month
    NSDictionary *monthConverter = @{
        @"01" : @"January",
        @"02" : @"February",
        @"03" : @"March",
        @"04" : @"April",
        @"05" : @"May",
        @"06" : @"June",
        @"07" : @"July",
        @"08" : @"August",
        @"09" : @"September",
        @"10" : @"October",
        @"11" : @"November",
        @"12" : @"December"
    };

    // used to remove the 0 at the beging of singe digit days
    NSDictionary *dayConverter = @{
        @"01" : @"1",
        @"02" : @"2",
        @"03" : @"3",
        @"04" : @"4",
        @"05" : @"5",
        @"06" : @"6",
        @"07" : @"7",
        @"08" : @"8",
        @"09" : @"9",
    };
    
    // converts yyyy-mm-dd into an array containing [yyyy, mm, dd]
    NSArray *rawDateArray = [unformatedDate componentsSeparatedByString:@"-"];
    NSString *year = rawDateArray[0];
    NSString *month = monthConverter[rawDateArray[1]];
    NSString *day = rawDateArray[2];
    
    if ([dayConverter objectForKey:day] != nil) { // if day is a single digit use dayConverter
        day = dayConverter[day];
    }
    
    NSString *date = [NSString stringWithFormat:@"%@ %@, %@", month, day, year];
    
    return date;
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
