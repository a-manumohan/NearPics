//
//  AlbumCollectionViewCell.h
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCollectionViewCell : UICollectionViewCell

@property (nonatomic,retain) IBOutlet UILabel *albumName;
@property (nonatomic,retain) IBOutlet UIImageView *photo1;
@property (nonatomic,retain) IBOutlet UIImageView *photo2;
@property (nonatomic,retain) IBOutlet UIImageView *photo3;
@property (nonatomic,retain) IBOutlet UIImageView *photo4;

- (void)setDataToView:(NSDictionary *)picPlaceDic;
@end
