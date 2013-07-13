//
//  ViewController.m
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "ViewController.h"
#import "AlbumCollectionViewCell.h"
#import "PhotosViewController.h"

@interface ViewController (){
	NSMutableArray *picPlaceArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.title = @"NearPics";
    FlickrManager *manager = [FlickrManager sharedInstance];
    manager.delegate = self;
    [manager startLocationUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


- (void)loadedNearestPlaceWithDictionary:(NSDictionary *)picPlaceDic{
    if(picPlaceArray == nil){
		picPlaceArray = [[NSMutableArray alloc] init];
	}
	[picPlaceArray addObject:picPlaceDic];
	[self performSelectorOnMainThread:@selector(addNewCellToCollectionWithDictionary:) withObject:picPlaceDic waitUntilDone:YES];
}
- (void)addNewCellToCollectionWithDictionary:(NSDictionary *)picPlaceDic{
	int index = [picPlaceArray count];
	NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:index-1 inSection:0]];
	[self.albumCollection insertItemsAtIndexPaths:indexPaths];
}
#pragma mark - collection view delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	if (picPlaceArray == nil) {
		return 0;
	}
	return [picPlaceArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	AlbumCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"albumCell"forIndexPath:indexPath];

	[cell setDataToView:[picPlaceArray objectAtIndex:indexPath.row]];
	return cell;
}


#pragma mark - segue methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if([segue.identifier isEqualToString:@"showPicsSegue"]){
		PhotosViewController *photosViewController = segue.destinationViewController;
		NSIndexPath *indexPath = [[self.albumCollection indexPathsForSelectedItems] objectAtIndex:0];
		photosViewController.picPlaceDictionary = [picPlaceArray objectAtIndex:indexPath.row];
	}
}
@end
