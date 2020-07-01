//
//  MovieCollectionCell.h
//  Flix
//
//  Created by zurken on 6/26/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterView;

@property (nonatomic, strong) Movie *movie;

@end

NS_ASSUME_NONNULL_END
