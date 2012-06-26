//
//  GameLayer.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 29/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BallGrid;
@class Ball;


@interface GameLayer : CCLayer 
{
    
    BallGrid * theGrid;
    
    int score;
    
    CCLabelBMFont * scoresLabel;
    
}
 


// only called once
//- (void) initGame;
- (void) firstCreationGrid;
- (void) newGame;
- (void) restartGame;
- (void) takeBack;
- (void) win;


@end
