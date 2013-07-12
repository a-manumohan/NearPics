//
//  ViewController.h
//  NearPics
//
//  Created by manuMohan on 10/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrManager.h"
#import "PlacesManager.h"

@interface ViewController : UIViewController<PlacesManagerDelegate,FlickerManagerDelegate>

@end
