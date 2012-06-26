//
//  ACArray2dim.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 20/11/2011.
//  Copyright 2011 Westminster University. All rights reserved.
//

#import "ACArray2dim.h"

@implementation ACArray2dim

+ (id) makeArrayX:(int)X Y:(int)Y
{
    return [[self alloc] initArrayX:X Y:Y];
}

- (id)initArrayX:(int)X Y:(int)Y
{
    self = [super init];
    if (self) 
    {
        array_ = [[CCArray alloc] initWithCapacity:X];
        
        for (int i = 0; i < X; i++)
        {
            CCArray * temp = [[CCArray alloc] initWithCapacity:Y];
            
            [array_ addObject:temp];
        }
        
        [array_ retain];
    }
    
    
    return self;
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) objectAtX:(int)X Y:(int)Y
{
    return nil;
}

- (id) objectAtPoint:(CGPoint)point
{
    return nil;
}

- (BOOL) objectExistsAtX:(int)X Y:(int)Y
{
    return NO;
}

- (BOOL) objectExistsAtPoint:(CGPoint)point
{
    return NO;
}

- (void) addObjectInColumn:(int)column object:(id)object
{
    
}

- (void) insertObjectAtX:(int)X Y:(int)Y object:(id)object
{
    
}

- (void) insertObjectAtPoint:(CGPoint)point object:(id)object
{
    
}

- (void) dealloc
{
    [array_ release];
    
    [super dealloc];
}

@end
