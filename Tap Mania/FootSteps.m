//
//  FootSteps.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 13/10/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "FootSteps.h"
#import "FootNode.h"
#import "BallGrid.h"


@implementation FootSteps


- (id) init
{
    self = [super init];
    
    if (self)
    {
        stack_ = [[NSMutableArray alloc]init];
        count = 0;
    }
    
    return self;
}

- (void) pushStep:(id)theObject
{
    [theObject retain];
    [stack_ addObject:theObject];
#ifdef DEBUG
    NSLog(@"Object at %d: %@", count + 1, [stack_ objectAtIndex:count]);
#endif
    count++;
}

- (id) popStep
{
    id theObject = nil;
    
    if (count > 0)
    {
        theObject = [[[stack_ lastObject]retain]autorelease];
        [stack_ removeLastObject];
        count--;
    }
    
    return theObject;
}

- (NSString*) description
{
    return [stack_ description];
}

- (void) removeAllSteps
{
    [stack_ removeAllObjects];
    count = 0;
}


- (void) dealloc
{
    [stack_ release];
    [super dealloc];
}

@end
