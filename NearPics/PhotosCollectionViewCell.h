//
//  PhotosCollectionViewCell.h
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotosCollectionViewCell : UICollectionViewCell

- (void)loadThumbNailForPhoto:(Photo *)photo;
@end
