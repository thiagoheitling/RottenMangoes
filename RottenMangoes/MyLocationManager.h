//
//  MyLocationManager.h
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-02.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface MyLocationManager : NSObject

@property (nonatomic) CLLocation *currentLocation;

+ (id) sharedManager;
- (void) startLocationMonitoring;

@end
