//
//  UILayer.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 30/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//


#import "UILayer.h"
#import "MainLayer.h"
#import "GameLayer.h"
#import "constants.h"

@interface UILayer (PrivateMethods)

- (void) showButtons;
- (void) makeHide;
//- (void) askForNewGame;
//- (void) askForRestartGame;

- (void) newGame;
- (void) restartGame;
- (void) showScores;
- (void) undoMove;

- (BOOL) isTouchForMe:(CGPoint)touchlocation;

@end


@implementation UILayer

@synthesize sprNew = _sprNew;
@synthesize sprNewPressed = _sprNewPressed;

@synthesize sprRestart = _sprRestart;
@synthesize sprRestartPressed = _sprRestartPressed;

@synthesize sprScores = _sprScores;
@synthesize sprScoresPressed = _sprScoresPressed;

@synthesize sprUndo = _sprUndo;
@synthesize sprUndoPressed = _sprUndoPressed;

#pragma mark - construction, destruction


- (id) init
{
    if (self = [super init])
    {
        
        
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        _sprNew = [CCSprite spriteWithFile:@"new.png"];
        _sprNew.position = CGPointMake(kNewButtonXPos, winSize.height - kButtonHeight/2);
        _sprNewPressed = [CCSprite spriteWithFile:@"newPressed.png"];
        _sprNewPressed.position = _sprNew.position;
        _sprNewPressed.opacity = 0;
        
        _sprRestart = [CCSprite spriteWithFile:@"restart.png"];
        _sprRestart.position = CGPointMake(kRestartButtonXPos, winSize.height - kButtonHeight/2);
        _sprRestartPressed = [CCSprite spriteWithFile:@"restartPressed.png"];
        _sprRestartPressed.position = _sprRestart.position;
        _sprRestartPressed.opacity = 0;
        
        
        _sprScores = [CCSprite spriteWithFile:@"scores.png"];
        _sprScores.position = CGPointMake(kScoresButtonXPos, winSize.height - kButtonHeight/2);
        _sprScoresPressed = [CCSprite spriteWithFile:@"scoresPressed.png"];
        _sprScoresPressed.position = _sprScores.position;
        _sprScoresPressed.opacity = 0;
        
        _sprUndo = [CCSprite spriteWithFile:@"undo.png"];
        _sprUndo.position = CGPointMake(kUndoButtonXPos, winSize.height - kButtonHeight/2);
        _sprUndoPressed = [CCSprite spriteWithFile:@"undoPressed.png"];
        _sprUndoPressed.position = _sprUndo.position;
        _sprUndoPressed.opacity = 0;
        
        [self addChild:_sprNew];
        [self addChild:_sprNewPressed];

        [self addChild:_sprRestart];
        [self addChild:_sprRestartPressed];
        
        [self addChild:_sprScores];
        [self addChild:_sprScoresPressed];
        
        [self addChild:_sprUndo];
        [self addChild:_sprUndoPressed];
        
        
        self.isTouchEnabled = YES;
    }
    

    
    return self;
}

- (void) dealloc
{
    
    [self.sprNew release];
    [self.sprNewPressed release];
    
    [self.sprRestart release];
    [self.sprRestartPressed release];
    
    [self.sprScores release];
    [self.sprScoresPressed release];
    
    [self.sprUndo release];
    [self.sprUndoPressed release];
    
    [super dealloc];
}

#pragma mark - private methods: selectors

- (void) newGame
{
    [[MainLayer sharedLayer].gameLayer newGame];
}

- (void) restartGame
{
    [[MainLayer sharedLayer].gameLayer restartGame];
}

- (void) showScores
{
    
    
}

- (void) undoMove
{
    [[MainLayer sharedLayer].gameLayer takeBack];
}


#pragma mark - touches

- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];    
}

- (BOOL) isTouchForMe:(CGPoint)touchlocation
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    BOOL isInRect = CGRectContainsPoint(CGRectMake(0, winSize.height - kButtonHeight, winSize.width, winSize.height), touchlocation);
    
    return isInRect;
}


- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [MainLayer locationFromTouch:touch];


    
    
    BOOL handleTouch = [self isTouchForMe:touchLocation];
    
    if (handleTouch)
    {

        int x = touchLocation.x;
        // find out which button was pressed
//
        CCSprite * currentButton = nil;
        
        if ((x > kNewButtonXPos - kButtonWidth/2) && (x < kButtonWidth/2 + kNewButtonXPos))
        {
            [self newGame];
            currentButton = self.sprNewPressed;
        }
        else if ((x > kRestartButtonXPos - kButtonWidth/2) && (x < kRestartButtonXPos + kButtonWidth/2)) 
        {
            [self restartGame];
            currentButton = self.sprRestartPressed;
        }
        else if ((x > kScoresButtonXPos - kButtonWidth/2) && (x < kScoresButtonXPos + kButtonWidth/2)) 
        {
            [self showScores];
            currentButton = self.sprScoresPressed;
        }
        else if ((x > kUndoButtonXPos - kButtonWidth/2) && (x < kUndoButtonXPos + kButtonWidth/2))
        {
            [self undoMove];
            currentButton = self.sprUndoPressed;
        }
        
        // highlight the button for .5 secs, animating the opacity to 0 on the selected sprite
        id opacity = [CCFadeTo actionWithDuration:0.7 opacity:0];
        
        [currentButton stopAllActions];

        currentButton.opacity = 255;
        [currentButton runAction:opacity];
        
        
    }
    
    return handleTouch;
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

//- (void) askForNewGame
//{
////    UIView * view = [[CCDirector sharedDirector] openGLView];
//    
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Game"
//                                                     message:@"Start a new game?" 
//                                                    delegate:self 
//                                           cancelButtonTitle:@"Cancel"
//                                           otherButtonTitles:@"Ok", nil];
//    
//    [alert show];
//    [alert release];
//    
//}

//- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"BLAH");
//}



@end
