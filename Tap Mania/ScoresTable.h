//
//  ScoresTable.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 20/06/2012.
//  Copyright 2012 Westminster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"

@interface ScoresTable : CCLayer 
<UITableViewDelegate, UITableViewDataSource>{}


@property (retain, nonatomic) AppDelegate * appDelegate;
@property (retain, nonatomic) UIView * scoresView;

@end
