//
//  Queue.h
//  NearPics
//
//  Created by manuMohan on 12/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Queue : NSObject{
    NSMutableArray *queue;
}

- (void)enqueue:(id)object;
- (id)dequeue;
@end
