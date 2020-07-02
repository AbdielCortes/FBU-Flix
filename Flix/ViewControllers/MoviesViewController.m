//
//  MoviesViewController.m
//  Flix
//
//  Created by zurken on 6/25/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "Movie.h"
#import "MovieApiManager.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *movies;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.activityIndicator startAnimating];
    [self getTableData];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTableData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)getTableData {
    MovieApiManager *manager = [MovieApiManager new];
    [manager fetchNowPlaying:^(NSMutableArray *movies, NSError *error) {
        if (error != nil && error.code == NSURLErrorNotConnectedToInternet) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unable to Load Movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];

            // create an reload action
            UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self getTableData];
            }];
            // add the reload action to the alert controller
            [alert addAction:reloadAction];
            
            // show alert box
            [self presentViewController:alert animated:YES completion:^{ }];
        }
        else {
            self.movies = movies;
            [self.tableView reloadData]; // reloads table view to make sure movies are displayed
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    cell.movie = self.movies[indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:tappedCell];
    Movie *movie = self.movies[cellIndexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

@end
