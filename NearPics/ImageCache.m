//
//  ImageCache.m
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "ImageCache.h"
static ImageCache *sharedCache = NULL;
@implementation ImageCache
@synthesize cache;

+(ImageCache *)sharedInstance{
	if(sharedCache == NULL){
		sharedCache = [[ImageCache alloc] init];
	}
	return sharedCache;
}

- (NSData *)getImage:(NSString *)url{
	if([[cache allKeys] containsObject:url]){
		return [cache objectForKey:url];
	}
	return nil;
}
- (void)storeImage:(NSData *)data withUrl:(NSString *)url{
	if (cache == nil) {
		cache = [[NSMutableDictionary alloc] init];
	}
	[cache setValue:data forKey:url];
}

- (void)clearCache {
	[cache removeAllObjects];
}
@end
