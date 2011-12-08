//
//  BaseLayer.h
//  mimicontrol
//
//  Created by 加藤 寛人 on 11/12/08.
//  Copyright KatokichiSoft 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class Plane;

// BaseLayer
@interface BaseLayer : CCLayer
{
	Plane *plane_;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
