//
//  Theatre.m
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-02.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "Theatre.h"

@interface Theatre ()

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *address;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation Theatre

- (instancetype)initWithTitle:(NSString *)title address:(NSString *)address andCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _title = title;
        _address = address;
        _coordinate = coordinate;
    }
    return self;
}

@end
