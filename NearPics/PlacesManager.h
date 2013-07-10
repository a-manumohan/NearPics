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

@interface PlacesManager : NSObject<ASIHTTPRequestDelegate>

+ (PlacesManager *)sharedInstance;

- (void)getPlacesNearLat:(NSString *)lat andLong:(NSString *)lon;
@end
