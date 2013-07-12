//
//  PlacesManager.h
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//
#define PLACES_API_KEY @"AIzaSyCKa7t_UCz5IvQzIRst66aXwkTEq4c3h5M"

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Place.h"
#import <CoreLocation/CoreLocation.h>

@protocol PlacesManagerDelegate <NSObject>

-(void)loadedPlacesWithArray:(NSArray *)places;

@end
@interface PlacesManager : NSObject<ASIHTTPRequestDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

+ (PlacesManager *)sharedInstance;

@property (nonatomic,assign) id<PlacesManagerDelegate>delegate;

- (void)getPlacesNearLat:(NSString *)lat andLong:(NSString *)lon;
@end
