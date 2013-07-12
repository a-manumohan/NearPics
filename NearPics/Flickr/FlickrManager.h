//
//  FlickrManager.h
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectiveFlickr.h"
#import "PlacesManager.h"
#import "Venue.h"
#import "Queue.h"
#import "Photo.h"

@protocol FlickerManagerDelegate

- (void)loadedNearestPlaceWithDictionary:(NSDictionary *)picPlaceDic;

@end
@interface FlickrManager : NSObject<OFFlickrAPIRequestDelegate,PlacesManagerDelegate>
@property (nonatomic, assign) id<FlickerManagerDelegate> delegate;
+ (FlickrManager *)sharedInstance;

//start monitoring location
- (void)startLocationUpdate;
//get nearest venues
- (void)getVenuesNearPlace:(Place *)place;
@end
