//
//  MovieCell.h
//  Flix
//
//  Created by zurken on 6/25/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterView;

@property (nonatomic, strong) Movie *movie;

@end

NS_ASSUME_NONNULL_END
