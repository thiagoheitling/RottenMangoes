//
//  CollectionViewCell.m
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-01.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Movie.h"

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (nonatomic) NSURLSessionTask *task;

@end

@implementation CollectionViewCell

- (void)configureWithMovie:(Movie *)movie
{
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    self.posterImage.image = nil;
    
    [self.task cancel];
    
    self.task = [sharedSession dataTaskWithURL:movie.posterURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        UIImage *image = [UIImage imageWithData:data];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.posterImage.image = image;
        });
        
    }];
    
    [self.task resume];
}

@end
