//
//  PhotoView.m
//  NearPics
//
//  Created by Arshad T P on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "PhotoView.h"
#import "ImageCache.h"

@interface PhotoView(){
	ImageCache *imageCache;
	UIActivityIndicatorView *activityView;
}

@end
@implementation PhotoView

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
- (void)loadImageForPhoto:(Photo *)photo{
	imageCache = [ImageCache sharedInstance];
	
	dispatch_queue_t mainqueue = dispatch_get_main_queue();
	dispatch_queue_t imagequeue = dispatch_queue_create("com.nearpic.imagephotoqueue", NULL);
	imageCache = [ImageCache sharedInstance];
	self.photoLabel.text = photo.title;
	NSString *photoUrl = [FlickrManager urlOfPhoto:photo ofSize:kLarge];
	
	NSData *imageData = [imageCache getImage:photoUrl];
	activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	if(imageData){
		[self setPhotoDataToView:imageData];
	}else{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
		[self addSubview:activityView];
		[activityView startAnimating];
		dispatch_async(imagequeue, ^{
			NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]];
			[imageCache storeImage:imageData withUrl:photoUrl];
			dispatch_async(mainqueue, ^{
				[activityView stopAnimating];
				[activityView removeFromSuperview];
				[self setPhotoDataToView:imageData];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			});
		});
	}
}

- (IBAction)closeView:(id)sender {
	[self removeFromSuperview];
}

- (void)setPhotoDataToView:(NSData *)data{
	UIImage *image = [UIImage imageWithData:data];
	[self.photoImageView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	[self.photoImageView setImage:image];
}
@end
