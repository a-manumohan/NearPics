//
//  ViewController.h
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrManager.h"

@interface ViewController : UIViewController<FlickerManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *albumCollection;

@end
