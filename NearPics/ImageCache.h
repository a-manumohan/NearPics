//
//  ImageCache.h
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

@property (nonatomic,retain) NSMutableDictionary *cache;

+(ImageCache *)sharedInstance;

- (NSData *)getImage:(NSString *)url;
- (void)storeImage:(NSData *)data withUrl:(NSString *)url;

- (void)clearCache;
@end
