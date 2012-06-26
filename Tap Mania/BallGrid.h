//
//  BallGrid.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 13/10/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Ball;
@class FootNode;
@class FootSteps;

@interface BallGrid : NSObject
{
    CCArray * gridColumns;
    
    
    // just save the color of the ball for restart game.
    // better using CCArray?
    CCArray * printGrid;
    FootNode * currentTurn;
    FootSteps * turns;
    
    int numRows;
    int numColumns;
    
    
    
}

@property (nonatomic, readonly) CCArray * gridColumns;
@property (nonatomic, retain) CCArray * printGrid;

// Inits
+ (id) makeGrid:(int) columns :(int)rows;
- (id) initGridWithColumns:(int)columns withRows:(int)rows;
- (void) makeNewGrid;
- (void) ballsFromPrintGrid;

// Grid operations
- (void) removeObjectAtX:(int)x atY:(int)y;
- (int) ballsClickedAtCoord:(CGPoint)coordinate;
- (int) gridRowCountAt:(int)pos;
- (Ball*) objectAtX:(int)x atY:(int)y;
- (Ball*) objectAtPoint:(CGPoint)thePoint;
- (void) putBallsBack;
- (void) updateBalls;
- (void) checkColumns;

- (void) removeDirtyBalls;


- (void) removeAllObjectsFromGrid;

- (BOOL) ballExistsAtX:(int)x atY:(int)y;
- (BOOL) checkGameOver;
- (BOOL) checkGameWon;



@end
