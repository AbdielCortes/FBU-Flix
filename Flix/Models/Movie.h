//
//  Movie.h
//  Flix
//
//  Created by zurken on 7/1/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *rating;

@property (nonatomic, strong) NSString *posterUrlString;
@property (nonatomic, strong) NSString *backdropUrlString;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
