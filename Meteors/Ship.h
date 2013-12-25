//
//  Ship.h
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MovingObject.h"
@protocol ShipDelegate <NSObject>

-(void)shipDestroyed;

@end
@interface Ship : MovingObject

@property (nonatomic, weak) id<ShipDelegate> delegate;

-(void)move:(double)x y:(double)y;
@end
