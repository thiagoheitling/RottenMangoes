//
//  Movie.h
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-01.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *posterURL;
@property (nonatomic) NSURL *reviewURL;

- (instancetype)initWithTitle:(NSString *)title reviewURL:(NSURL *)reviewURL AndPosterURL:(NSURL *)posterURL;

@end
