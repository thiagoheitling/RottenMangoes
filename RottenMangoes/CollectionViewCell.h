//
//  CollectionViewCell.h
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-01.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie;

@interface CollectionViewCell : UICollectionViewCell

- (void)configureWithMovie:(Movie *)movie;

@end
