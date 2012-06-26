//
//  GameLayer.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 29/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "GameLayer.h"
#import "Ball.h"
#import "constants.h"
#import "MainLayer.h"
#import "BallGrid.h"


@interface GameLayer (PrivateMethods) 

- (void) removeSpriteFromScreen:(id) sender;
//- (void) animateBallDisappear:(Ball*)theBall;
- (void) moveBalls;
- (void) removeAllBallSprites;
- (void) putNewBallsOnScreen;
- (void) removeNoMoreMovesLabel;

- (NSString *) stopWatchTime:(int)time;
- (void) tick:(ccTime)time;
- (void) scheduleTimer;
- (void) unscheduleTimer;


@end


@implementation GameLayer

//@synthesize theGrid;
//@synthesize reactToInput_;

#pragma mark - Initializations

- (id) init
{
    if (self = [super init])
    {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        theGrid = nil;
        
        score = 0;
        
        self.isTouchEnabled = YES;
        
        // make a scores label
        scoresLabel = [CCLabelBMFont labelWithString:[self stopWatchTime:0] fntFile:@"scoresBMP.fnt"];
           
        // put in on screen at top middle
        scoresLabel.position = ccp(winSize.width/2, 
                                   winSize.height-(scoresLabel.contentSize.height/2) - kScoresYOffset);
        
        // Adjust the label's anchorPoint's y position to make it align with the top.
//        scoresLabel.anchorPoint = CGPointMake(59.0, 45.0);
        
        // give tag
        scoresLabel.tag = KSCORESTAG;
        
        // place it on the screen
        [self addChild:scoresLabel z:3];
        
        [self scheduleTimer];
        
//        self.isTouchEnabled = YES;
    }
    

    return self;
}

- (void) firstCreationGrid
{
    theGrid = [[BallGrid makeGrid:kColumns :kRows] retain];
    [theGrid makeNewGrid];
}


- (void) newGame
{
    [self unscheduleTimer];
    
    [self removeNoMoreMovesLabel];
    
    [self removeAllBallSprites];
    [theGrid makeNewGrid];
    
    score = 0;
    
    [self scheduleTimer];
        
}

- (void) restartGame
{
    [self removeNoMoreMovesLabel];
    [self removeAllBallSprites];
    [theGrid ballsFromPrintGrid];
}


#pragma mark - Ball operations

- (void) takeBack
{
    [self removeNoMoreMovesLabel];
    [theGrid putBallsBack];
}


// tabula rasa
- (void) removeAllBallSprites
{
    for (int i = 0; i < [[theGrid gridColumns] count]; i++)
    {
        for (int j = 0; j < [theGrid gridRowCountAt:i]; j++)
        {
            CCSprite * theBall = [[theGrid objectAtX:i atY:j] ballSprite_];

            [self removeChild:theBall cleanup:YES];
        }
    }
    
    [theGrid removeAllObjectsFromGrid];
}


#pragma mark - touches

//- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touch");
//}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [MainLayer locationFromTouch:touch];
    
        
    int x = (touchLocation.x - kXOffset) / kBallDiameter;
    int y = (touchLocation.y - kYOffset) / kBallDiameter;
    
    // crash
//    NSLog(@"gridcolumn from theGrid: %@", [theGrid gridColumns]);

    
    int numberBalls = 0;
    
    
    BOOL isTouchHandled = ([theGrid ballExistsAtX:x atY:y]);

    if (isTouchHandled)
    {
        
        // check if ball has same color neighbour . function should just return the number
        
        numberBalls = [theGrid ballsClickedAtCoord:CGPointMake(x, y)];
        
        [theGrid removeDirtyBalls];
        [theGrid checkColumns];
        [theGrid updateBalls];
        
        if ([theGrid checkGameWon])
        {
            
            // stop timer
            [self unscheduleUpdate];    

            
            // game won
            CCLabelTTF* label = [CCLabelTTF labelWithString:@"YOU WIN !!!"
                                                   fontName:@"Marker Felt" fontSize:32];
            
            [self win];
            
            // get the window (screen) size from CCDirector
            CGSize size = [[CCDirector sharedDirector] winSize];
            // position the label at the center of the screen
            label.position =  CGPointMake(size.width / 2, size.height / 2);
            
            label.tag = KWINLABELTAG;
            
            // add the label as a child to this Layer
            [self addChild: label];

            
            // animate something for reward
            
            
            
            // save score in db
            
            
            // get out
            return isTouchHandled;
        }
        
        if ([theGrid checkGameOver])
        {
            CCLabelTTF* label = [CCLabelTTF labelWithString:@"No more moves"
                                             fontName:@"Marker Felt" fontSize:32];
            
            // get the window (screen) size from CCDirector
            CGSize size = [[CCDirector sharedDirector] winSize];
            // position the label at the center of the screen
            label.position =  CGPointMake(size.width / 2, size.height / 2);
            
            label.tag = KLABELTAG;
            
            // add the label as a child to this Layer
            [self addChild: label];
        }
        else 
        {            
            [self removeNoMoreMovesLabel];
            
        }
                

    }
    
    return isTouchHandled;
    
}

// this layer is last to receive touch events.
- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}



#pragma mark - drawing

- (void) removeSpriteFromScreen:(id)sender
{
    // good practice to check
    NSAssert([sender isKindOfClass:[CCSprite class]], @"Not a sprite");
    
    CCSprite * theSprite = (CCSprite*)sender;
    
    [self removeChild:theSprite cleanup:YES];
    
}

- (void) draw
{
    // some custome drawing here ...
}

#pragma mark - Timer and stopwatch



- (NSString *) stopWatchTime:(int)time;
{
    int secs = time % 60;
    int mins = (time / 60) % 60;
    int hour = (time / 3600);
    
    NSString * scoreText = nil;
    
    if (time < 60)
    {
        scoreText =  [NSString stringWithFormat:@"%.2d", secs];
    }
    else if (time >= 60 && time < 3600)
    {
        scoreText =  [NSString stringWithFormat:@"%.2d:%.2d", mins, secs];
    }
    else 
    {
        scoreText =  [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour, mins, secs];
    }
    
    return scoreText;
}

- (void) scheduleTimer
{
    [self schedule:@selector(tick:) interval:1.0];
}

- (void) unscheduleTimer
{
    [self unschedule:@selector(tick:)];    
}

- (void) tick:(ccTime)time
{
    score++;
    
    [scoresLabel setString:[self stopWatchTime:score]];

}

#pragma mark - Winning and TableViews
     

- (void) win
{
    // stop timer
    [self unschedule:@selector(tick:)];    
    
    
    // game won
    CCLabelTTF* label = [CCLabelTTF labelWithString:@"YOU WIN !!!"
                                           fontName:@"Marker Felt" fontSize:32];
        
    // get the window (screen) size from CCDirector
    CGSize size = [[CCDirector sharedDirector] winSize];
    // position the label at the center of the screen
    label.position =  CGPointMake(size.width / 2, size.height / 2);
    
    label.tag = KWINLABELTAG;
    
    // add the label as a child to this Layer
    [self addChild: label];
    
    
    // save score in db
    
    

    
    // some particles for the user's reward ...
    
    CCParticleSystem * system;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM
              particleWithFile:@"TapWin.plist"];
    
    system.position = CGPointMake(winSize.width / 2, winSize.height / 2);
    
    [self addChild:system];
}


#pragma mark - EndGame and Dealloc

- (void) removeNoMoreMovesLabel
{
    [self removeChild:[self getChildByTag:KLABELTAG] cleanup:NO];
    [self removeChild:[self getChildByTag:KWINLABELTAG] cleanup:NO];
}

- (void) dealloc
{
    
    [theGrid release];
    
    [self unscheduleUpdate];
    
    [super dealloc];

}




@end
