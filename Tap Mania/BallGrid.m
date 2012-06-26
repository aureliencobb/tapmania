 //
//  BallGrid.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 13/10/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "BallGrid.h"
#import "constants.h"
#import "ball.h"
#import "FootSteps.h"
#import "FootNode.h"
#import "GameLayer.h"
#import "MainLayer.h"

@interface BallGrid (PrivateMethods)

//- (void) checkFourNeighborsAtX:(int)x atY:(int)y;
- (int) checkNeighboursAtX:(int)X atY:(int)Y;
- (void) addObjectAtCoords:(CGPoint) coordinates andObject:(id)theObject;
- (void) makeBallsAppearFromFootNode:(FootNode*)step;
- (void) putBackColumnsFromFootNode:(FootNode*)step;
//- (void) moveBallsBackFromFootNode:(FootNode*)step;

@end


@implementation BallGrid

@synthesize gridColumns;
@synthesize printGrid;


#pragma mark - Initializations

+(id) makeGrid:(int)columns :(int)rows
{
    return [[[self alloc] initGridWithColumns:columns withRows:rows] autorelease];
}

- (id) initGridWithColumns:(int)columns withRows:(int)rows
{
    
    if(self = [super init])
    {
        numRows = rows;
        numColumns = columns;
        
        turns = [[FootSteps alloc] init];
        
        //[self makeNewGrid];
        
    }
    
    return self;
}

- (void) makeNewGrid
{
    
    if(printGrid)
    {
        [printGrid removeAllObjects];
        [printGrid release];
        printGrid = nil;
    }
    
    printGrid = [CCArray arrayWithCapacity:numColumns];
    
    int theColor;
    
    for (int i = 0; i < numColumns; i++)
    {
        
        CCArray * printRows = [CCArray arrayWithCapacity:numRows];
        
        for (int j = 0; j < numRows; j++)
        {
            theColor = arc4random() % KNUMBEROFBALLS;
            
            [printRows addObject:[NSNumber numberWithInt:theColor]];
            
        }
        
        [printGrid addObject:printRows];
        
    }
    
    [printGrid retain];

#ifdef DEBUG    
//    NSLog(@"printGrid created: %@", printGrid);
#endif
    
    [self ballsFromPrintGrid];
}


// this also will move all balls
- (void) updateBalls
{
    int numCols = [gridColumns count];
    
    for (int i = 0; i < numCols; i++)
    {
        int theRows = [self gridRowCountAt:i];
        
        for (int j = 0; j < theRows; j++)
        {
            Ball * currentBall = [self objectAtX:i atY:j];
            
            [currentBall setPositionInGrid:CGPointMake(i, j)];
            [currentBall animateBallTo:CGPointMake(i, j)];
            
        }
    }
         
}


- (void) ballsFromPrintGrid
{
    // remove everything from theGrid
    
    if (gridColumns)
    {

    
        [gridColumns removeAllObjects];
        [gridColumns release];
        gridColumns = nil;
        
    }
    
    
    gridColumns = [CCArray arrayWithCapacity:numColumns];
    
    [turns removeAllSteps];
    
    for (int i = 0; i < numColumns; i++)
    {
        CCArray * theRows = [CCArray arrayWithCapacity:numRows];
        
        for (int j = 0; j < numRows; j++)
        {
            CCArray *aRow = [printGrid objectAtIndex:i];
            
            
            int theColor = [[aRow objectAtIndex:j]intValue];
            
            
            Ball * theBall = [Ball makeBallAt:CGPointMake(i, j) andColor:theColor];
            
            [theBall animateBallAppearWithDelay:0.0f];
            
            [theRows addObject:theBall];
            
        }
        
        [gridColumns addObject:theRows];
    }
    
    [gridColumns retain];
}

#pragma mark - Grid Operations

// returns the number of balls that go
- (int) ballsClickedAtCoord:(CGPoint)coordinate
{
    int ballColor = [[self objectAtPoint:coordinate] color_]; 
                     
    currentTurn = [[FootNode alloc]initWithBallColor:ballColor];
    
    // this result is not the number of balls that go.
    [self checkNeighboursAtX:coordinate.x atY:coordinate.y];
    


    int numberOfBalls = [currentTurn numberOfBalls]; 
    
    if (numberOfBalls > 0)
    {
        [turns pushStep:currentTurn];
  
    }
    
    [currentTurn release];

    
    return numberOfBalls;
}

- (void) removeDirtyBalls
{

    int numCols = [gridColumns count];

    for (int i = 0; i < numCols; i++)
    {   
        
        for (int j = 0; j < [self gridRowCountAt:i]; j++)
        {
            
            int ballsAbove = [self gridRowCountAt:i];
            
            while ([[self objectAtX:i atY:j] isDirty] && ballsAbove > j)
            {
                
                Ball * ballToRemove = [self objectAtX:i atY:j];
                
                [ballToRemove animateBallDisappear];
                
                [self removeObjectAtX:i atY:j];
                
                ballsAbove--;
            }
        }
    }

}

- (void) removeObjectAtX:(int)x atY:(int)y
{
    if ([gridColumns count] > x)
    {
        NSMutableArray * theArray = [gridColumns objectAtIndex:x];
        
        [theArray removeObjectAtIndex:y];
                
        for (int i = y; i < [theArray count]; i++)
        {
            Ball * theBall = [theArray objectAtIndex:i];
            theBall.positionInGrid = CGPointMake(x, i);
        }
    }
}

- (void) addObjectAtCoords:(CGPoint)coordinates andObject:(id)theObject
{
    
    CCArray * theArray = [gridColumns objectAtIndex:coordinates.x];
    
    [theArray insertObject:theObject atIndex:coordinates.y];
    
}

// returns the number of balls in a given column
// if the column doesnt exists, it return 0
- (int) gridRowCountAt:(int)pos
{
    if ([gridColumns count] > pos)
        return [[gridColumns objectAtIndex:pos] count];
    else
        return 0;
}


- (Ball*) objectAtPoint:(CGPoint)thePoint
{
    return [self objectAtX:thePoint.x atY:thePoint.y];
}

// return a ball in the given grid position
// return nil if no ball there
- (Ball*) objectAtX:(int)x atY:(int)y
{
    if ([self ballExistsAtX:x atY:y])
    {
        
        return [[gridColumns objectAtIndex:x]objectAtIndex:y];   
        
    }
    
    return nil;
}

- (void) putBallsBack
{
    // get turn
    FootNode * footNode = [turns popStep];
    
    int ballCount = [footNode numberOfBalls];
    
    // put columns back if any
    for (int c = 0; c < [[footNode columns] count]; c++)
    {
        CCArray * theArray = [[CCArray alloc] initWithCapacity:numRows];

        
        int theColumn = [[[footNode columns] objectAtIndex:c] intValue];
        
        [gridColumns insertObject:theArray atIndex:theColumn];
        
    }
    
    // put balls back
    for (int i = 0; i < ballCount; i++)
    {
        
        CGPoint point = [footNode getPointFromIndex:i];
        
        
        Ball * newBall = [Ball makeBallAt:point andColor:[footNode ballColor]];
        
        [self addObjectAtCoords:point andObject:newBall];

        
    }
    
    
    [self updateBalls];
    
    //
    [self makeBallsAppearFromFootNode:footNode];

}

- (void) putBackColumnsFromFootNode:(FootNode *)step
{
    
    int numCols = [[step columns] count];
    
    for (int c = 0; c < numCols; c++)
    {
        CCArray * theArray = [[CCArray alloc] initWithCapacity:numRows];
        
        
        int theColumn = [[[step columns] objectAtIndex:c] intValue];
        
        [gridColumns insertObject:theArray atIndex:theColumn];
        
    }
}

- (void) makeBallsAppearFromFootNode:(FootNode*)step
{
        
    // aurelien
    int ballCount = [[step balls] count];
    
    for (int i = 0; i < ballCount; i++)
    {
        
        CGPoint point = [step getPointFromIndex:i];

        Ball * currentBall = [self objectAtPoint:point];
        
        // CCSprite * ballsprite = [currentBall ballSprite_];
        
        //[ballsprite setScale:0.1f];

        // not necessary ...
        [currentBall animateBallAppearWithDelay:0.1];
    }
    
}

#pragma mark - Checks

- (BOOL) ballExistsAtX:(int)x atY:(int)y
{
    BOOL ballExists = NO;
    
    if ([gridColumns count] > x)
    {
        if ([[gridColumns objectAtIndex:x] count] > y)
        {
            ballExists = YES;
        }
    }
    
    return ballExists;
}


- (void) checkNeighboursAtX:(int)cx atY:(int)cy
{
    // current ball
    Ball * cBall = [self objectAtX:cx atY:cy];
    
    int theColor = [cBall color_];
    
    
    // ball above
    Ball * tBall = nil;
    if ([self ballExistsAtX:cx atY:cy + 1])
    {
        tBall = [self objectAtX:cx atY:cy + 1];
    }
    
    // ball below
    Ball * bBall = nil;
    if ([self ballExistsAtX:cx atY:cy - 1])
    {
        bBall = [self objectAtX:cx atY:cy - 1];
    }
    
    // ball left
    Ball * lBall = nil;
    if ([self ballExistsAtX:cx - 1 atY:cy])
    {
        lBall = [self objectAtX:cx - 1 atY:cy];
    }
    
    // ball right
    Ball * rBall = nil;
    if ([self ballExistsAtX:cx + 1 atY:cy])
    {
        rBall = [self objectAtX:cx + 1 atY:cy];
    }
    
    // check neighbours
    if (lBall && (lBall.color_ == theColor) && !lBall.isDirty)
    {
        [lBall setIsDirty:YES];
        [currentTurn addBallCoords:CGPointMake(cx - 1, cy)];
        [self checkNeighboursAtX:cx - 1 atY:cy];
    }
    if (rBall && (rBall.color_ == theColor) && !rBall.isDirty)
    {
        [rBall setIsDirty:YES];
        [currentTurn addBallCoords:CGPointMake(cx + 1, cy)];
        [self checkNeighboursAtX:cx + 1 atY:cy];

    }
    if (tBall && (tBall.color_ == theColor) && !tBall.isDirty)
    {
        [tBall setIsDirty:YES];
        [currentTurn addBallCoords:CGPointMake(cx, cy + 1)];
        [self checkNeighboursAtX:cx atY:cy + 1];

    }
    if (bBall && (bBall.color_ == theColor) && !bBall.isDirty)
    {
        [bBall setIsDirty:YES];
        [currentTurn addBallCoords:CGPointMake(cx, cy - 1)];
        [self checkNeighboursAtX:cx atY:cy - 1];

    }
    
}

- (void) checkColumns
{
    
    int numCols = [gridColumns count];
    
    for (int i = 0; i < numCols; i++)
    {
        
        while (([self gridRowCountAt:i] == 0) 
               && ([[self gridColumns] count] > i))
        {
            [gridColumns removeObjectAtIndex:i];
            [currentTurn addColumnIndex:i];
        }
        
    }
    
}

- (void) removeAllObjectsFromGrid
{
    [gridColumns removeAllObjects];
}


- (BOOL) checkGameOver
{
    
    int columns = [gridColumns count];
    
    
    
    for (int i = 0; i < columns; i++)
    {
        int rows = [[gridColumns objectAtIndex:i] count];
        
        for (int j = 0; j < rows; j++)
        {
            int ballColor = [self objectAtX:i atY:j].color_;
            
            if ([self ballExistsAtX:i atY:j + 1])
            {
                if (ballColor == [self objectAtX:i atY:j + 1].color_) return NO;
            }
            if([self ballExistsAtX:i + 1 atY:j])
            {
                if (ballColor == [self objectAtX:i + 1 atY:j].color_) return NO;
            }
        }
    }
    

    // show a game over label or something
    return YES;
}


- (BOOL) checkGameWon
{
    if ([self ballExistsAtX:0 atY:0]) return NO;
    else return YES;
}

- (void) dealloc
{
    [turns removeAllSteps];
        
    [gridColumns release];
    
    [turns release];
    
    [super dealloc];
}

@end
