//
//  PhotoView.h
//  NearPics
//
//  Created by Arshad T P on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "FlickrManager.h"

@interface PhotoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


- (void)loadImageForPhoto:(Photo *)photo;
- (IBAction)closeView:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@end
