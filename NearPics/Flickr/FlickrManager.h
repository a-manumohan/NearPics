//
//  FlickrManager.h
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectiveFlickr.h"
@protocol FlickerManagerDelegate

- (void)loadedNearestPlacesWithDictionary:(NSDictionary *)places;

@end
@interface FlickrManager : NSObject<OFFlickrAPIRequestDelegate>
@property (nonatomic, assign) id<FlickerManagerDelegate> delegate;
+ (FlickrManager *)sharedInstance;

//get nearest venues
- (void)getVenuesNearLocation:(NSDictionary *)location;
@end
