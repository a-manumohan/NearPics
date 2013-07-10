//
//  FlickrManager.m
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#define API_KEY @"301bf50b2d6d51f24a216d5169f111e3"
#define API_SECRET @"84882cc0b3d0a8e1"

#import "FlickrManager.h"
static FlickrManager *sharedManager = NULL;

@interface FlickrManager(){
    OFFlickrAPIContext *flickerContext;
    
    OFFlickrAPIRequest *placesRequest;
}

@end
@implementation FlickrManager

- (id)init{
    self = [super init];
    if(self){
        flickerContext = [[OFFlickrAPIContext alloc] initWithAPIKey:API_KEY sharedSecret:API_SECRET];
    }
    return self;
}
//returns a singleton object
+ (FlickrManager *)sharedInstance{
    if(sharedManager == NULL){
        sharedManager = [[FlickrManager alloc] init];
    }
    return sharedManager;
}

- (void)getVenuesNearLocation:(NSDictionary *)location{
    placesRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickerContext];
    [placesRequest setDelegate:self];
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:@"9.9667",@"lat",@"76.2167",@"lon", nil];
    [placesRequest callAPIMethodWithPOST:@"flickr.places.findByLatLon" arguments:args];
}

#pragma mark - flickr delegate methods
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary{
    NSLog(@"%@",inResponseDictionary);
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError{
     NSLog(@"%@",inError);
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(NSUInteger)inSentBytes totalBytes:(NSUInteger)inTotalBytes{
     NSLog(@"%lu",(unsigned long)inTotalBytes);
}
@end
