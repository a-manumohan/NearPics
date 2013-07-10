//
//  PlacesManager.m
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//
#define PLACES_URL @"https://maps.googleapis.com/maps/api/place/nearbysearch/json"

#import "PlacesManager.h"
static PlacesManager *sharedManager = NULL;
@implementation PlacesManager

+ (PlacesManager *)sharedInstance{
    if(sharedManager == NULL){
        sharedManager = [[PlacesManager alloc] init];
    }
    return sharedManager;
}

- (void)getPlacesNearLat:(NSString *)lat andLong:(NSString *)lon{
    NSString *completeUrl = [NSString stringWithFormat:@"%@?location=%@,%@&radius=%@&sensor=true&key=%@",
                             PLACES_URL,lat,lon,@"1000",PLACES_API_KEY];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:completeUrl]];
    request.delegate = self;
    [request startAsynchronous];
}

#pragma mark - ASIHttp delegate methods
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"%@",request.responseString);
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
}
@end
