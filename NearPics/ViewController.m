//
//  ViewController.m
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    PlacesManager *manager = [PlacesManager sharedInstance];
//    manager.delegate = self;
//    [manager getPlacesNearLat:@"13.0810" andLong:@"80.2740"];
    FlickrManager *manager = [FlickrManager sharedInstance];
    manager.delegate = self;
    [manager startLocationUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - placesmanager delegate method
-(void)loadedPlacesWithArray:(NSArray *)places{
    
}
- (void)loadedNearestPlaceWithDictionary:(NSDictionary *)picPlaceDic{
    
}
@end
