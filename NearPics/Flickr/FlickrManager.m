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
    
    OFFlickrAPIRequest *placeRequest;
    OFFlickrAPIRequest *photoRequest;
    
    Queue *placesQueue;
    Queue *venueQueue;
    PlacesManager *placesManager;
    NSMutableArray *venueArray;
    BOOL loading;
    BOOL photoLoading;
    
    Venue *currentVenue;
}

@end
@implementation FlickrManager

- (id)init{
    self = [super init];
    if(self){
        flickerContext = [[OFFlickrAPIContext alloc] initWithAPIKey:API_KEY sharedSecret:API_SECRET];
        venueArray = [[NSMutableArray alloc] init];
        placesQueue = [[Queue alloc] init];
        venueQueue = [[Queue alloc] init];
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
- (void)startLocationUpdate{
    placesManager = [PlacesManager sharedInstance];
    placesManager.delegate = self;
}
- (void)clearVenues{
	[venueArray removeAllObjects];
}
- (void)getVenuesNearby{
    Place *place = [placesQueue dequeue];
    loading = YES;
    if(place == nil){
        loading = NO;
        return;
    }
    
    placeRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickerContext];
    [placeRequest setDelegate:self];
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:place.latitude,@"lat",place.longitude,@"lon", nil];
    [placeRequest callAPIMethodWithPOST:@"flickr.places.findByLatLon" arguments:args];
}
- (void)getPhotosInVenueQueue{
    Venue *venue = [venueQueue dequeue];
    currentVenue = venue;
    photoLoading = YES;
    if(venue == nil){
        photoLoading = NO;
        return;
    }
    photoRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickerContext];
    [photoRequest setDelegate:self];
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:venue.woeid,@"woe_id", nil];
    [photoRequest callAPIMethodWithPOST:@"flickr.photos.search" arguments:args];
}

#pragma mark - flickr delegate methods
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary{
   // NSLog(@"%@",inResponseDictionary);
    if(inRequest == placeRequest){
        Venue *v = [self parseVenueResponse:inResponseDictionary];
		if(![venueArray containsObject:v.woeid]){
			[venueQueue enqueue:v];
			[venueArray addObject:v.woeid];
		}
        
        if(!photoLoading){
            [self getPhotosInVenueQueue];
        }
        [self performSelectorOnMainThread:@selector(getVenuesNearby) withObject:nil waitUntilDone:NO];
    }
    if(inRequest == photoRequest){
        NSArray *photos = [self parsePhotosResponse:inResponseDictionary];
        NSDictionary *picPlaceDic = [NSDictionary dictionaryWithObjectsAndKeys:currentVenue,@"venue",photos,@"photos",nil];
        [self performSelectorOnMainThread:@selector(callViewUpdateMethod:) withObject:picPlaceDic waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(getPhotosInVenueQueue) withObject:nil waitUntilDone:YES];
    }
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError{
     NSLog(@"%@",inError);
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(NSUInteger)inSentBytes totalBytes:(NSUInteger)inTotalBytes{
     NSLog(@"%lu",(unsigned long)inTotalBytes);
}

#pragma mark - placesmanger delegate methods
-(void)loadedPlacesWithArray:(NSArray *)places{
    for(Place*place in places){
        [placesQueue enqueue:place];
    }
    if(!loading){
        [self getVenuesNearby];
    }
}

#pragma mark - venue parser method
- (Venue *)parseVenueResponse:(NSDictionary *)venueResponse{
    Venue *venue = [[Venue alloc] init];
    NSDictionary *place = [[[venueResponse objectForKey:@"places"] objectForKey:@"place"] objectAtIndex:0];
    venue.woeid = [place valueForKey:@"woeid"];
    venue.name = [place valueForKey:@"woe_name"];
    return venue;
}
#pragma mark - venue parser method
- (NSArray *)parsePhotosResponse:(NSDictionary *)photoResponse{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSArray *photoArray = [[photoResponse objectForKey:@"photos"] objectForKey:@"photo"];
    for(NSDictionary *photoDic in photoArray){
        Photo *photo = [[Photo alloc] init];
        photo.farm = [photoDic valueForKey:@"farm"];
        photo.photo_id = [photoDic valueForKey:@"id"];
        photo.secret = [photoDic valueForKey:@"secret"];
        photo.server = [photoDic valueForKey:@"server"];
        photo.title = [photoDic valueForKey:@"title"];
        [photos addObject:photo];
    }
    return photos;
}

#pragma mark - update view in main thread
- (void)callViewUpdateMethod:(NSDictionary *)placePicDic{
    [self.delegate loadedNearestPlaceWithDictionary:placePicDic];
}

#pragma mark - public methods
+ (NSString *)urlOfPhoto:(Photo *)photo ofSize:(kPhotoSize)size{
	NSString *url;
	if(size == kSmall){
		url = @"http://farm%@.staticflickr.com/%@/%@_%@_s.jpg";
	}else if(size == kMedium){
		url = @"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg";
	}else if (size == kLarge){
		url = @"http://farm%@.staticflickr.com/%@/%@_%@_b.jpg";
	}
	url = [NSString stringWithFormat:url,photo.farm,photo.server,photo.photo_id,photo.secret];
	return url;
}
@end
