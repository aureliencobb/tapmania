//
//  Ball.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 30/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//  Ball have an animate status. This makes the code moew complex, but only 
//  balls that need animation will be animated after an action is performed
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum 
{
    
    eRed,       // 0
    eBlue,      // 1
    eGreen,     // 2
    eYellow,    // 3
    ePurple     // 4
    
}Color;

@interface Ball : NSObject 
{
    
    CCSprite * ballSprite_;
    
    Color color_;
    
    CCLayer * parentLayer;
    
    BOOL isDirty;
    
//    BOOL animateBall;
    
    CGPoint positionInGrid;
    
}

@property (readonly) Color color_;
@property (nonatomic) BOOL isDirty;
@property (nonatomic) CGPoint positionInGrid;
@property (nonatomic, retain) CCSprite * ballSprite_;
//@property (nonatomic) BOOL animateBall;


+ (id) makeBallAt:(CGPoint) posInGrid andColor:(int)ballColor;


- (id) initWithPos:(CGPoint) position andColor:(int)ballColor;

- (void) animateBallTo:(CGPoint) destination;

- (void) animateBallDisappear;

- (void) animateBallAppearWithDelay:(float)theDelay;//:(id)onScreen;

- (CGPoint) convertCoordToScreenPosition:(CGPoint)coords;

//- (void) putBall:(id)sender;


@end
