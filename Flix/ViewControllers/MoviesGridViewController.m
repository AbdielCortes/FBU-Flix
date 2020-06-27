//
//  MoviesGridViewController.m
//  Flix
//
//  Created by zurken on 6/26/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *movies;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    
    CGFloat postersPerRow = 3;
    CGFloat posterWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerRow - 1)) / postersPerRow;
    CGFloat posterHeight = posterWidth * 1.5;
    layout.itemSize = CGSizeMake(posterWidth, posterHeight);
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error != nil) {
                   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unable to Load Movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
                    
                   // optional cancel action
//                   UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
//                        handler:^(UIAlertAction * _Nonnull action) { }];
//                   // add the cancel action to the alertController
//                   [alert addAction:cancelAction];

                   // create an reload action
                   UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       [self fetchMovies];
                   }];
                   // add the reload action to the alert controller
                   [alert addAction:reloadAction];
                   
                   // show alert box
                   [self presentViewController:alert animated:YES completion:^{ }];
                   
                   NSLog(@"%@", [error localizedDescription]);
               }
               else {
                   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                   
    //               NSLog(@"%@", dataDictionary);
                   self.movies = dataDictionary[@"results"]; // stores data acuired from the api
    //               for (NSDictionary *movie in self.movies) {
    //                   NSLog(@"%@", movie[@"title"]);
    //               }
                   
                   [self.collectionView reloadData]; // reloads collection view to make sure movies are displayed
               }
            [self.refreshControl endRefreshing];
           }];
        [task resume];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
      
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = [baseURLString stringByAppendingString:movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    cell.moviePosterView.image = nil;
    [cell.moviePosterView setImageWithURL:posterURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[cellIndexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

@end
