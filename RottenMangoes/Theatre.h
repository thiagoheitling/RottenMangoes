//
//  Theatre.h
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-02.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Corelocation/CoreLocation.h>
#import "MapKit/Mapkit.h"

@interface Theatre : NSObject <MKAnnotation>

- (instancetype)initWithTitle:(NSString *)title address:(NSString *)address andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
