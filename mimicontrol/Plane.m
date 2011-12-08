//
//  Plane.m
//  mimicontrol
//
//  Created by 加藤 寛人 on 11/12/08.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "Plane.h"

@interface Plane ()
- (void) getNext;
- (CGRect)myRect;
@end

@implementation Plane
@synthesize isSelected=isSelected_;

- (id)init {
    self = [super init];
    if (self) {
		isMoving_ = NO;
		isSelected_ = NO;
		velocity_ = 200.0f;
		paths_ = [[CCArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [paths_ release];
    [super dealloc];
}
- (void) onEnter  
{  
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];  
    [super onEnter];  
}  
- (void) onExit  
{  
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];  
}  

#pragma mark -
-(void) addPosition:(CGPoint) position
{
	[paths_ addObject:[NSValue valueWithCGPoint:position]];
}

- (void) start
{
	if (!isMoving_) {
		if ([paths_ count] > 0) {
			
			isMoving_ = YES;
			CGPoint target = [[paths_ objectAtIndex:0] CGPointValue];
			
			float angle = CC_RADIANS_TO_DEGREES(atan2(self.position.y - target.y, self.position.x - target.x));
			angle += 90;
			angle *= -1;
			self.rotation = angle;
			
			[self runAction:[CCSequence actions:
							 [CCMoveTo actionWithDuration:ccpDistance(self.position,target)/velocity_
												 position:target],
							 [CCCallFunc actionWithTarget:self 
												 selector:@selector(getNext)],
							 nil]];		
		}
		else
		{
			isMoving_ = NO;
		}
	}
}

- (void) stop
{
	[paths_ removeAllObjects];
}

- (void) getNext
{
	if ([paths_ count] > 0) {
		isMoving_ = NO;
		[paths_ removeObjectAtIndex:0];
	}
	[self start];
}

#pragma mark -
- (CGRect)myRect
{  
    CGSize s = [self.texture contentSize];  
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);  
}  

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event  
{  
    if ( !CGRectContainsPoint([self myRect], [self convertTouchToNodeSpaceAR:touch]) )   
    {  
		isSelected_ = NO;
        return NO;
    }
	else
	{
		isSelected_ = YES;
		return YES;
	}
}

@end
