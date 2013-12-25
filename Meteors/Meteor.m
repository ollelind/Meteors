//
//  Meteor.m
//  Meteors
//
//  Created by Olle Lind on 17/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "Meteor.h"

@implementation Meteor

-(id)initWithPosition:(CGPoint)position{
    self = [self initWithImageNamed:@"Comet"];
    if(self){
        if(IS_IPHONE){
            [self setScale:0.5];
        }
        self.position = position;
        self.speed = 20;
        
        [self configureCollisionBody];
        //[self initEmitter];

    }
    return self;
}

-(void)initEmitter{
    SKEmitterNode *trail = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Star" ofType:@"sks"]];
    trail.position = CGPointMake(0, 0);
    trail.zPosition = -1;
    [self addChild:trail];

}

- (void)configureCollisionBody {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = PhysicsMeteor;
    self.physicsBody.contactTestBitMask = PhysicsShip;
    self.physicsBody.collisionBitMask = 0;
}

@end
