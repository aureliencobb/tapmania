//
//  FootNode.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 13/10/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface FootNode : NSObject
{
    
    CCArray * balls;
    
    int ballColor;
    int numberOfBalls;
    
    CCArray * columns;
}

@property (nonatomic, retain) CCArray * balls;
@property (nonatomic, retain) CCArray * columns;
@property (nonatomic) int ballColor;
@property (nonatomic) int numberOfBalls;


- (id) initWithBallColor:(int)theColor;
- (void) addBallCoords:(CGPoint) coordinates;
- (void) addColumnIndex:(int) theindex;
- (CGPoint) getPointFromIndex:(int)index;

@end
