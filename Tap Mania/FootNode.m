//
//  FootNode.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 13/10/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "FootNode.h"

@interface FootNode (ACprivatemethods)

//- (void) sortBalls;
    
@end


@implementation FootNode

@synthesize balls;
@synthesize columns;
@synthesize ballColor;
@synthesize numberOfBalls;

- (id)initWithBallColor:(int)theColor
{
    self = [super init];
    
    if (self) 
    {
        ballColor = theColor;
        // Initialization code here.
        balls = [[CCArray alloc] init];
        columns = [[CCArray alloc] init];
        
        numberOfBalls = 0;
    }
    
    return self;
}

- (void) addBallCoords:(CGPoint)coordinates
{
    //int numBalls = numberOfBalls;
    
    if (numberOfBalls == 0)
    {
        [balls addObject:[NSValue valueWithCGPoint:coordinates]];
        numberOfBalls++;
        return;
    }
    
    int i = 0;
    
        
    for (i = 0; i < numberOfBalls; i++)
    {
        NSValue * wrap = [balls objectAtIndex:i];
        CGPoint ourPoint = [wrap CGPointValue];
        int py = ourPoint.y;
        
        if (coordinates.y < py)
        {
            break;
        }
//        else
//        {
//            insertAtEnd = YES;
//        }
//        
//#ifdef DEBUG
//        int px = ourPoint.x;
//        NSLog(@"Ball (%d, %d) added to FootNode", px, py);
//        NSLog(@"The Ball array is now: %@", balls);
//#endif
    }
    
    if (i == numberOfBalls)
        [balls addObject:[NSValue valueWithCGPoint:coordinates]];
    else
        [balls insertObject:[NSValue valueWithCGPoint:coordinates] atIndex:i];
    
    //[balls addObject:[NSValue valueWithCGPoint:coordinates]];
    numberOfBalls++;
}

- (CGPoint) getPointFromIndex:(int)index
{
    NSValue * wrapper = [balls objectAtIndex:index];
    
    CGPoint point = [wrapper CGPointValue];
    
    return point;
}

// when a column disappear in a turn
- (void) addColumnIndex:(int)theindex
{
    [columns addObject:[NSNumber numberWithInt:theindex]]; 
}

//- (void) sortBalls
//{
//    
//}

- (void) dealloc
{
    [balls release];
    [columns release];
    
    [super dealloc];
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"\\nColor: %d\\nnumberOfBalls: %d\\nballs: %@", ballColor, numberOfBalls, balls];
}

@end
