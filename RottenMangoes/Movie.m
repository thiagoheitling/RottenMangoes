//
//  Movie.m
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-01.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title reviewURL:(NSURL *)reviewURL AndPosterURL:(NSURL *)posterURL
{
    self = [super init];
    if (self)
    {
        _title = title;
        _posterURL = posterURL;
        _reviewURL = reviewURL;
    }
    return self;
}
@end
