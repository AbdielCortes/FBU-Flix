//
//  MovieCell.h
//  Flix
//
//  Created by zurken on 6/25/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterView;

@end

NS_ASSUME_NONNULL_END
