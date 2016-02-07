//
//  MasterCollectionViewController.m
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-01.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "MasterCollectionViewController.h"
#import "DetailViewController.h"
#import "Movie.h"
#import "CollectionViewCell.h"

@interface MasterCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *movies;

@end

@implementation MasterCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movies = [[NSMutableArray alloc]init];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j"];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!data)
        {
            NSLog (@"no data, error %@", error);
            return;
        }
        // parse json
        NSError *jsonError = nil;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        NSLog(@"json is %@", json);
        
        NSArray *movieDictionaries = json [@"movies"];
        
        for (NSDictionary *movieDict in movieDictionaries)
        {
            if (![movieDict isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"not a dictionary");
                continue;
            }
            
            NSString *movieTitle = movieDict[@"title"];
            
            NSDictionary *posters = movieDict[@"posters"];
            NSString *posterURLString = posters[@"detailed"];
            NSURL *posterURL = [NSURL URLWithString:posterURLString];

            NSDictionary *links = movieDict[@"links"];
            NSString *reviewURLString = links[@"reviews"];
            NSURL *reviewURL = [NSURL URLWithString:reviewURLString];
            
            Movie *movie = [[Movie alloc] init];
            
            movie.title = movieTitle;
            movie.posterURL = posterURL;
            movie.reviewURL = reviewURL;
            
            [self.movies addObject:movie];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
        
        NSLog(@"collected %i movies", [self.movies count]);
        
    }];
    
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetails"])
    {
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
        DetailViewController *dvc = [segue destinationViewController];
        dvc.movie = self.movies[indexPath.row];
    }
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Movie *movie = self.movies[indexPath.row];
    [cell configureWithMovie:movie];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
