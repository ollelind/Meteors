//
//  MovingObject.m
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "MovingObject.h"

@implementation MovingObject

-(CGFloat)x{
    return self.position.x;
}
-(CGFloat)y{
    return self.position.y;
}


- (void)update:(CFTimeInterval)timeSpan{}

- (void)collidedWith:(SKPhysicsBody *)body contact:(SKPhysicsContact *)contact{
    
}

@end
