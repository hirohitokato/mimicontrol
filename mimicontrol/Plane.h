//
//  Plane.h
//  mimicontrol
//
//  Created by 加藤 寛人 on 11/12/08.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Plane : CCSprite <CCTargetedTouchDelegate>{

	CCArray *paths_; // 移動先の座標群
	BOOL isSelected_;	// 現在選択されているか
	BOOL isMoving_;		// 現在移動中かどうか
	
	float velocity_;	// 移動速度
}
-(void) addPosition:(CGPoint)position;
-(void) start;
-(void) stop;

@property (nonatomic, assign) BOOL isSelected;

@end
