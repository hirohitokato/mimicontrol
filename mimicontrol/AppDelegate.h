//
//  AppDelegate.h
//  mimicontrol
//
//  Created by 加藤 寛人 on 11/12/08.
//  Copyright KatokichiSoft 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
