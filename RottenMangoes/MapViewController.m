//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Thiago Heitling on 2016-02-02.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "MapViewController.h"
#import "MyLocationManager.h"
#import "Theatre.h"
#import <MapKit/MapKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

#define zoomingMapArea 2100

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) MyLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSMutableArray *theatres;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initiateMap];
    
}

- (void) initiateMap
{
    MyLocationManager *myLocationManager = [MyLocationManager sharedManager];
    NSLog(@"My location in MapViewController is %@", myLocationManager.currentLocation);
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(myLocationManager.currentLocation.coordinate.latitude, myLocationManager.currentLocation.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoomingMapArea, zoomingMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    self.currentLocation = myLocationManager.currentLocation;
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else
        {
            CLPlacemark *placemark = [placemarks firstObject];
            
            if (placemark)
            {
                NSString *zipCode = [placemark postalCode];
                [self downloadTheatreInfo:zipCode];
            }
        }
        
    }];
    
}

-(void)downloadTheatreInfo:(NSString *)zipCode
{
    NSString *urlString = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=";
    urlString = [urlString stringByAppendingString:zipCode];
    urlString = [urlString stringByAppendingString:@"&movie="];
    urlString = [urlString stringByAppendingString:self.movie.title];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error)
        {
            NSError *jsonError = nil;
            NSDictionary *dictFromJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSArray *theatresFromJSONDict = [dictFromJSON objectForKey:@"theatres"];
            self.theatres = [[NSMutableArray alloc] init];
            
            for (NSDictionary *theatre in theatresFromJSONDict)
            {
                NSString *name = [theatre objectForKey:@"name"];
                NSString *address = [theatre objectForKey:@"address"];
                NSNumber *lat = [theatre objectForKey:@"lat"];
                NSNumber *lng = [theatre objectForKey:@"lng"];
                
                CLLocationCoordinate2D theatreLocation = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
                Theatre *newTheatre = [[Theatre alloc] initWithTitle:name address:address andCoordinate:theatreLocation];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.mapView addAnnotation:newTheatre];
                });
                
            }
        }
    }];
    [dataTask resume];
}

//- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    
//}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [view setCanShowCallout:YES];
}


-(void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
