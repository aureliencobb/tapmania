//
//  MainLayer.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 30/09/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "MainLayer.h"
#import "GameLayer.h"
#import "UILayer.h"

@implementation MainLayer

@synthesize gameLayer;
@synthesize uiLayer;

// semi singleton accessible through this static pointer
static MainLayer* mainLayerInstance;

+ (MainLayer*) sharedLayer
{
    // make sure instance exists
    NSAssert(mainLayerInstance != nil, @"MainLayer unavailable");
    return mainLayerInstance;
}


+ (CGPoint) locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+ (id) scene
{
    
    CCScene * scene = [CCScene node];
    
    MainLayer * layer = [MainLayer node];
    
    [scene addChild:layer];
    
    return scene;
    
}

- (GameLayer *) gameLayer
{
    CCNode * layer = [self getChildByTag:tagGameLayer];
    NSAssert([layer isKindOfClass:[GameLayer class]] , @"The Layer is not of type GameLayer");
    return (GameLayer*)layer;
}

- (id) init
{
    if (self = [super init])
    {
        NSAssert(mainLayerInstance == nil, @"Another instance of MainLayer is already running");
        
        mainLayerInstance = self;
        
        uiLayer = [UILayer node];
        gameLayer = [GameLayer node];

        [self addChild:uiLayer z:0 tag:tagUILayer];

        [self addChild:gameLayer z:1 tag:tagGameLayer];
        
        // ac test
        [gameLayer firstCreationGrid];
    }
    
    return self;
}



- (void) dealloc
{
    
    mainLayerInstance = nil;
    
    [super dealloc];
    
}

@end
