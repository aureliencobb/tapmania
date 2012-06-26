//
//  ACArray2dim.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 20/11/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ACArray2dim : NSObject
{
    CCArray * array_;
}

+ (id) makeArrayX:(int)X Y:(int)Y;

- (id) initArrayX:(int)X Y:(int)Y;

- (id) objectAtX:(int)X Y:(int)Y;
- (id) objectAtPoint:(CGPoint)point;

- (BOOL) objectExistsAtX:(int)X Y:(int)Y;
- (BOOL) objectExistsAtPoint:(CGPoint)point;

- (void) addObjectInColumn:(int)column object:(id)object;

- (void) insertObjectAtX:(int)X Y:(int)Y object:(id)object;
- (void) insertObjectAtPoint:(CGPoint)point object:(id)object;

@end
