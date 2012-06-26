//
//  FootSteps.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 13/10/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//  Heap implementation to keep track of steps

#import <Foundation/Foundation.h>


@class BallGrid;

@interface FootSteps : NSObject
{
    int count;
    NSMutableArray * stack_;
}


- (id) popStep;
- (void) pushStep:(id)theObject;
//- (id) returnTop;
- (void) removeAllSteps;

@end
