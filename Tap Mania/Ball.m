//
//  Ball.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 30/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "Ball.h"
#import "MainLayer.h"
#import "constants.h"
#import "GameLayer.h"

@interface Ball (PrivateMethods)

- (CCSprite*) getBallSprite:(NSInteger) color;
- (void) removeSpriteFromScreen:(id)sender;
- (void) putSpriteOnScreen:(id)sender;

@end



@implementation Ball

@synthesize color_;
@synthesize ballSprite_;
@synthesize positionInGrid;
@synthesize isDirty;

#pragma mark - INITIALIZATION

+ (id) makeBallAt:(CGPoint)posInGrid andColor:(int) ballColor
{
    return [[[self alloc] initWithPos:posInGrid andColor:ballColor]autorelease];
}

- (id) initWithPos:(CGPoint)thePosition andColor:(int)ballColor
{
    if (self = [super init])
    {
        
        color_ = ballColor; 
        
        ballSprite_ = [self getBallSprite:color_];
        
        positionInGrid = thePosition;
        
        ballSprite_.position = [self convertCoordToScreenPosition:thePosition];
        
        
        isDirty = NO;
        
    }
    
    return self;
}

#pragma mark - DRAWING and SPRITES

- (CCSprite*) getBallSprite:(NSInteger)color
{
    CCSprite * ballSprite = nil;
    
<<<<<<< master
=======
    // fetch sprites and animations from spritesheet here
    
    /*
>>>>>>> local
    switch (color)
    {
        case eRed:
            color_ = eRed;
            ballSprite = [CCSprite spriteWithFile:@"red_ball.png"];
            break;
        case eBlue:
            color_ = eBlue;
            ballSprite = [CCSprite spriteWithFile:@"blue_ball.png"];
            break;
        case eGreen:
            color_ = eGreen;
            ballSprite = [CCSprite spriteWithFile:@"green_ball.png"];
            break;
        case eYellow:
            color_ = eYellow;
            ballSprite = [CCSprite spriteWithFile:@"yellow_ball.png"];
            break;
        case ePurple:
            color_ = ePurple;
            ballSprite = [CCSprite spriteWithFile:@"purple_ball.png"];
            break;
        default:
            CCLOG(@"Couldnt assign sprite. wrong enum case");
    }
    */
    
    return ballSprite;
    
}

- (NSString *) description
{
    // aurelien
    return nil;
}

#pragma mark - ANIMATION

- (void) animateBallTo:(CGPoint)destination
{
    
    [ballSprite_ stopAllActions];
    
    CGPoint screenPosition = [self convertCoordToScreenPosition:destination];
    
    CCMoveTo * move = [CCMoveTo actionWithDuration:0.1 position:screenPosition];
    
    [ballSprite_ runAction:move];

}

- (CGPoint) convertCoordToScreenPosition:(CGPoint)coords
{
    
    
    int X = coords.x * 36 + kBallRadius + kXOffset;
    int Y = coords.y * 36 + kYOffset + kBallRadius;
    
    return CGPointMake(X, Y);

}

//-(void) update:(ccTime)delta
//{
//    ballSprite_.position = ccpAdd(ballSprite_.position, velocity_);
//}

- (void) animateBallDisappear
{
    id actionScale = [CCScaleTo actionWithDuration:0.1 scale:0.0];
    
    CCCallFunc * func = [CCCallFunc actionWithTarget:self selector:@selector(removeSpriteFromScreen:)];
    
    CCSequence * seq = [CCSequence actions:actionScale, func, nil];    
    
    [ballSprite_ runAction:seq];
    
}

- (void) removeSpriteFromScreen:(id)sender
{
    GameLayer * screen = [[MainLayer sharedLayer] gameLayer];
    // good practice to check
//    NSAssert([sender isKindOfClass:[CCSprite class]], @"Not a sprite");
    
//    CCSprite * theSprite = (CCSprite*)sender;
    
    [screen removeChild:ballSprite_ cleanup:YES];
}



- (void) animateBallAppearWithDelay:(float)theDelay
{
    
    [ballSprite_ stopAllActions];
    
    GameLayer * screen = [[MainLayer sharedLayer] gameLayer];
    
        
    [ballSprite_ setScale:0];

    
    id delay = [CCDelayTime actionWithDuration:theDelay];
    
    [ballSprite_ runAction:delay];
    
    [screen addChild:ballSprite_];

    
//    CCCallFuncN * func = [CCCallFuncN actionWithTarget:screen selector:@selector(putBall:)];
    
    id actionScale = [CCScaleTo actionWithDuration:0.1 scale:1];
    
   // CCSequence * seq = [CCSequence actions:delay,/* func,*/ actionScale, nil];
    
    [ballSprite_ runAction:actionScale];
    
}


#pragma mark - DEALLOC and END

- (void) dealloc
{


    [super dealloc];

}

@end
