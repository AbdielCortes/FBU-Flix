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
#import "Movie.h"
#import "MovieApiManager.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *movies;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self getCollectionData];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getCollectionData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    
    CGFloat postersPerRow = 3;
    CGFloat posterWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerRow - 1)) / postersPerRow;
    CGFloat posterHeight = posterWidth * 1.5;
    layout.itemSize = CGSizeMake(posterWidth, posterHeight);
}

- (void)getCollectionData {
    MovieApiManager *manager = [MovieApiManager new];
   [manager fetchNowPlaying:^(NSMutableArray *movies, NSError *error) {
       if (error != nil && error.code == NSURLErrorNotConnectedToInternet) {
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unable to Load Movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];

           // create an reload action
           UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               [self getCollectionData];
           }];
           // add the reload action to the alert controller
           [alert addAction:reloadAction];
           
           // show alert box
           [self presentViewController:alert animated:YES completion:^{ }];
       }
       else {
           self.movies = movies;
           [self.collectionView reloadData]; // reloads collection view to make sure movies are displayed
           [self.refreshControl endRefreshing];
       }
   }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    cell.movie = self.movies[indexPath.item];
    
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
    Movie *movie = self.movies[cellIndexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

@end
