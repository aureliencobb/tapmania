//
//  UILayer.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 30/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UILayer : CCLayer 
/*<UIAlertViewDelegate>*/


@property (retain, nonatomic) CCSprite * sprNew;
@property (retain, nonatomic) CCSprite * sprNewPressed;

@property (retain, nonatomic) CCSprite * sprRestart; 
@property (retain, nonatomic) CCSprite * sprRestartPressed;

@property (retain, nonatomic) CCSprite * sprScores;
@property (retain, nonatomic) CCSprite * sprScoresPressed;

@property (retain, nonatomic) CCSprite * sprUndo;
@property (retain, nonatomic) CCSprite * sprUndoPressed;

@end
