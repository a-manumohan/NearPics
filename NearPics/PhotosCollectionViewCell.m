//
//  PhotosCollectionViewCell.m
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "PhotosCollectionViewCell.h"
#import "FlickrManager.h"
#import "ImageCache.h"

@interface PhotosCollectionViewCell(){
	ImageCache *imageCache;
}

@end
@implementation PhotosCollectionViewCell

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

- (void)loadThumbNailForPhoto:(Photo *)photo{
	dispatch_queue_t mainqueue = dispatch_get_main_queue();
	dispatch_queue_t imagequeue = dispatch_queue_create("com.nearpic.thumbnailqueue", NULL);
	imageCache = [ImageCache sharedInstance];
	
	NSString *photoUrl = [FlickrManager urlOfPhoto:photo ofSize:kMedium];
	NSData *imageData = [imageCache getImage:photoUrl];
	if(imageData){
		self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
	}else{
		dispatch_async(imagequeue, ^{
			NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]];
			[imageCache storeImage:imageData withUrl:photoUrl];
			dispatch_async(mainqueue, ^{
				self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
			});
		});
	}
}
@end
