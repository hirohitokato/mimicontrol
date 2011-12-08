//
//  BaseLayer.m
//  mimicontrol
//
//  Created by 加藤 寛人 on 11/12/08.
//  Copyright KatokichiSoft 2011. All rights reserved.
//

#import "BaseLayer.h"
#import "Plane.h"

@implementation BaseLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BaseLayer *layer = [BaseLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];

		// 背景
		CCSprite *background = [CCSprite spriteWithFile:@"Horizon.png"]; // Appleのデスクトップピクチャを借用
		background.scale = 1.0 * CC_CONTENT_SCALE_FACTOR();
		background.position = ccp( size.width*0.5 , size.height*0.5 );
		[self addChild:background z:-1];

		// 画面上部のラベル
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"cocos2d Advent Calendar 2011 no.8" fontName:@"Helvetica" fontSize:24];
		label.position = ccp( size.width*0.5 , size.height*0.9 );
		label.skewX = 20.0;
		[self addChild:label z:20];

		// 飛行機
		plane_ = [[Plane spriteWithFile:@"plane.png"] retain];
		plane_.scale = 1.0f * CC_CONTENT_SCALE_FACTOR();
		plane_.position = ccp( size.width*0.5 , size.height*0.5 );
		[self addChild:plane_ z:10];

		// タッチイベントに反応開始
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
														 priority:100
												  swallowsTouches:YES];
	}
	return self;
}

- (void) dealloc
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[plane_ release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark -
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	CGPoint curPosition = [[CCDirector sharedDirector] convertToGL:touchLocation];	

	if (plane_.isSelected) {
		// 線の描画開始
		[plane_ stop];
		[self removeChildByTag:193 cleanup:YES];
		CCMotionStreak* line = [CCMotionStreak streakWithFade:999 
													   minSeg:6
														image:@"line.png" 
														width:6
													   length:10 
														color:ccc4(255, 255, 255, 255)];
		line.position = curPosition;
		[self addChild:line z:5 tag:193];
	}
	
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	CGPoint curPosition = [[CCDirector sharedDirector] convertToGL:touchLocation];

	CCMotionStreak *line = (CCMotionStreak *)[self getChildByTag:193];
	if (plane_.isSelected) {
		line.position = curPosition;

		[plane_ addPosition:curPosition];
		[plane_ start];
	}
} 

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	plane_.isSelected = NO;
}

@end
