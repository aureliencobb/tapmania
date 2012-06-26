//
//  MainLayer.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 30/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


typedef enum
{
    tagGameLayer,
    tagUILayer
}MultiLayerTags;

@class GameLayer;
@class UILayer;

@interface MainLayer : CCLayer 
{
    // ?
    BOOL isTouchForUI_;
    
    GameLayer * gameLayer;
    UILayer * uiLayer;
}

// accessor for the semi singleton
+ (MainLayer*) sharedLayer;

+ (CGPoint) locationFromTouch:(UITouch*) touch;

+ (id) scene;

@property (readonly) GameLayer * gameLayer;
@property (readonly) UILayer * uiLayer;

@end
