//
//  AppDelegate.h
//  Tap Mania
//
//  Created by Aurelien Cobb on 29/09/2011.
//  Copyright Westminster University 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@property (nonatomic, retain) NSArray* highScores;


@end
