//
//  DetailViewController.m
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-01.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.posterImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:self.movie.posterURL]];
    self.titleLabel.text = self.movie.title;
    
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showMap"])
    {
        MapViewController *dvc = [segue destinationViewController];
        
        dvc.movie = self.movie;
    }
}


@end
