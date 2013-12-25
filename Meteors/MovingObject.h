//
//  MovingObject.h
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_OPTIONS(uint32_t, CollisionType) {
    PhysicsShip      =1 << 0,
    PhysicsMeteor    =1 << 1,
    PhysicsBorders      =1 << 2,
};

@interface MovingObject : SKSpriteNode

-(id)initWithPosition:(CGPoint)position;
-(id)initObject;

- (void)update:(CFTimeInterval)timeSpan;
- (void)collidedWith:(SKPhysicsBody *)body contact:(SKPhysicsContact *)contact;

@property (nonatomic, assign) CGFloat speed;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@end
