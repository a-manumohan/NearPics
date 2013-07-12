//
//  Queue.m
//  NearPics
//
//  Created by manuMohan on 12/07/13.
//  Copyright (c) 2013 manuMohan. All rights reserved.
//

#import "Queue.h"

@implementation Queue

- (void)enqueue:(id)object{
    if(queue == nil || queue == NULL){
        queue = [[NSMutableArray alloc] init];
    }
    [queue addObject:object];
}

- (id)dequeue{
    if(queue == nil || queue == NULL || ([queue count] <= 0)){
        return nil;
    }
    id object = [queue objectAtIndex:0];
    [queue removeObjectAtIndex:0];
    return object;
}
@end
