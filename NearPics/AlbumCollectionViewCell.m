//
//  AlbumCollectionViewCell.m
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "AlbumCollectionViewCell.h"
#import "Venue.h"
#import "Photo.h"
#import "FlickrManager.h"
#import "ImageCache.h"

@interface AlbumCollectionViewCell(){
	NSString *photoUrl1;
	NSString *photoUrl2;
	NSString *photoUrl3;
	NSString *photoUrl4;
	ImageCache *imageCache;
}

@end
@implementation AlbumCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setDataToView:(NSDictionary *)picPlaceDic{
	Venue *venue = [picPlaceDic valueForKey:@"venue"];
	NSArray *photos = [picPlaceDic valueForKey:@"photos"];
	
	Photo *photo;
	
	imageCache = [ImageCache sharedInstance];
	photoUrl1 = nil;
	photoUrl2 = nil;
	photoUrl3 = nil;
	photoUrl4 = nil;
	
	if([photos count] >= 1){
		photo = [photos objectAtIndex:0];
		photoUrl1 = [FlickrManager urlOfPhoto:photo ofSize:kSmall];
		//[self.photo1 setImage:[UIImage ima]]
	}
	if([photos count] >= 2){
		photo = [photos objectAtIndex:1];
		photoUrl2 = [FlickrManager urlOfPhoto:photo ofSize:kSmall];
	}
	if([photos count] >= 3){
		photo = [photos objectAtIndex:2];
		photoUrl3 = [FlickrManager urlOfPhoto:photo ofSize:kSmall];
	}
	if([photos count] >= 4){
		photo = [photos objectAtIndex:3];
		photoUrl4 = [FlickrManager urlOfPhoto:photo ofSize:kSmall];
	}
	[self.albumName setText:venue.name];
	[self loadPhotoThumbnails];
}

- (void)loadPhotoThumbnails{
	dispatch_queue_t mainqueue = dispatch_get_main_queue();
	dispatch_queue_t imagequeue = dispatch_queue_create("com.nearpic.thumbnailqueue", NULL);
	if (photoUrl1) {
        NSData *imageData = [imageCache getImage:photoUrl1];
		if (imageData) {
			[self.photo1 setImage:[UIImage imageWithData:imageData]];
		}else{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            dispatch_async(imagequeue, ^{
				NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl1]];
				[imageCache storeImage:imageData withUrl:photoUrl1];
				dispatch_async(mainqueue, ^{
					[self.photo1 setImage:[UIImage imageWithData:imageData]];
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
				});
			});
		}
	}
	if (photoUrl2) {
		NSData *imageData = [imageCache getImage:photoUrl2];
		if (imageData) {
			[self.photo2 setImage:[UIImage imageWithData:imageData]];
		}else{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
			dispatch_async(imagequeue, ^{
				NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl2]];
				[imageCache storeImage:imageData withUrl:photoUrl2];
				dispatch_async(mainqueue, ^{
					[self.photo2 setImage:[UIImage imageWithData:imageData]];
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
				});
			});
		}
	}
	if (photoUrl3) {
		NSData *imageData = [imageCache getImage:photoUrl3];
		if (imageData) {
			[self.photo3 setImage:[UIImage imageWithData:imageData]];
		}else{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
			dispatch_async(imagequeue, ^{
				NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl3]];
				[imageCache storeImage:imageData withUrl:photoUrl3];
				dispatch_async(mainqueue, ^{
					[self.photo3 setImage:[UIImage imageWithData:imageData]];
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
				});
			});
		}
	}
	if (photoUrl4) {
		NSData *imageData = [imageCache getImage:photoUrl4];
		if (imageData) {
			[self.photo4 setImage:[UIImage imageWithData:imageData]];
		}else{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
			dispatch_async(imagequeue, ^{
				NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl4]];
				[imageCache storeImage:imageData withUrl:photoUrl4];
				dispatch_async(mainqueue, ^{
					[self.photo4 setImage:[UIImage imageWithData:imageData]];
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
				});
			});
		}
	}
}
@end
