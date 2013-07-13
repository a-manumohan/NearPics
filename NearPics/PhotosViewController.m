//
//  PhotosViewController.m
//  NearPics
//
//  Created by manuMohan on 7/13/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "PhotosViewController.h"
#import "Photo.h"
#import "Venue.h"
#import "PhotosCollectionViewCell.h"

@interface PhotosViewController (){
	NSArray *photosArray;
}

@end

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	if(self.picPlaceDictionary){
		Venue *venue = [self.picPlaceDictionary valueForKey:@"venue"];
		self.title = venue.name;
		photosArray = [self.picPlaceDictionary valueForKey:@"photos"];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - collection view delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	if (photosArray == nil) {
		return 0;
	}
	return [photosArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	PhotosCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell"forIndexPath:indexPath];
	
	[cell loadThumbNailForPhoto:[photosArray objectAtIndex:indexPath.row]];
	return cell;
}
@end
