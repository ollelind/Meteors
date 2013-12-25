//
//  BackgroundNode.h
//  Meteors
//
//  Created by Olle Lind on 22/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BackgroundNode : SKNode

@property (nonatomic, strong) SKNode *farAwayNode;
@property (nonatomic, strong) SKNode *middleNode;
@property (nonatomic, strong) SKNode *closeNode;
@property (nonatomic, strong) SKEmitterNode *farAwayStars;
@property (nonatomic, strong) SKEmitterNode *middleStars;
@property (nonatomic, strong) SKEmitterNode *closeStars;
@property (nonatomic) CGRect gameBounds;

-(id)initWithBounds:(CGRect)bounds;
-(void)speedUp;
-(void) tilt:(double)x;

@end
