//
//  Ship.m
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "Ship.h"

@implementation Ship

-(id)initWithPosition:(CGPoint)position{
    self = [self initWithImageNamed:@"Ship"];
    if(self){
        self.position = position;
        if(IS_IPHONE){
            [self setScale:0.5];
            self.speed = 20;
        }else{
            self.speed = 30;
        }
        
        [self configureCollisionBody];
    }
    return self;
}

-(void)move:(double)x y:(double)y{
    CGPoint newPosition = CGPointMake(self.x + (x * self.speed), self.y + (y * self.speed));
    self.position = newPosition;
}

- (void)configureCollisionBody {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = PhysicsShip;
    self.physicsBody.contactTestBitMask = PhysicsMeteor;
    self.physicsBody.collisionBitMask = PhysicsBorders;
}

- (void)collidedWith:(SKPhysicsBody *)body contact:(SKPhysicsContact *)contact{
    if(contact.bodyA.categoryBitMask == PhysicsMeteor || contact.bodyB.categoryBitMask == PhysicsMeteor){
        [self.delegate shipDestroyed];
    }
}


@end
