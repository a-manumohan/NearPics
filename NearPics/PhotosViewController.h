//
//  PhotosViewController.h
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewController : UIViewController

@property (nonatomic,retain) NSDictionary *picPlaceDictionary;

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;
@end
