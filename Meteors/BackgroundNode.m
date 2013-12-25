//
//  BackgroundNode.m
//  Meteors
//
//  Created by Olle Lind on 22/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "BackgroundNode.h"

@implementation BackgroundNode

-(id)initWithBounds:(CGRect)bounds{
    self = [self init];
    if(self){
        self.gameBounds = bounds;
        self.farAwayNode = [SKNode new];
        self.middleNode = [SKNode new];
        self.closeNode = [SKNode new];
        [self addChild:self.farAwayNode];
        [self addChild:self.middleNode];
        [self addChild:self.closeNode];
        [self initStars];
    }
    return self;
}

-(void)initStars{
    if(IS_IPHONE){
        self.farAwayStars = [self spaceStarEmitterNodeWithBirthRate:25
                                                              scale:0.4
                                                           lifetime:(self.gameBounds.size.height/5)
                                                              speed:-100
                                                              color:[SKColor lightGrayColor]
                                                    enableStarLight:NO];
        
        self.middleStars = [self spaceStarEmitterNodeWithBirthRate:14
                                                             scale:0.6
                                                          lifetime:(self.gameBounds.size.height/5)
                                                             speed:-150
                                                             color:[SKColor lightGrayColor]
                                                   enableStarLight:NO];
        
        self.closeStars = [self spaceStarEmitterNodeWithBirthRate:18
                                                            scale:1
                                                         lifetime:(self.gameBounds.size.height/5)
                                                            speed:-200
                                                            color:[SKColor lightGrayColor]
                                                  enableStarLight:NO];
    }else{
        self.farAwayStars = [self spaceStarEmitterNodeWithBirthRate:16
                                                              scale:0.25
                                                           lifetime:(self.gameBounds.size.height/5)
                                                              speed:-70
                                                              color:[SKColor lightGrayColor]
                                                    enableStarLight:NO];
        
        self.middleStars = [self spaceStarEmitterNodeWithBirthRate:8
                                                             scale:0.5
                                                          lifetime:(self.gameBounds.size.height/5)
                                                             speed:-100
                                                             color:[SKColor lightGrayColor]
                                                   enableStarLight:NO];
        
        self.closeStars = [self spaceStarEmitterNodeWithBirthRate:12
                                                            scale:1
                                                         lifetime:(self.gameBounds.size.height/5)
                                                            speed:-120
                                                            color:[SKColor lightGrayColor]
                                                  enableStarLight:NO];
    }
    
    
    [self.farAwayNode addChild:self.farAwayStars];
    [self.middleNode addChild:self.middleStars];
    [self.closeNode addChild:self.closeStars];
}

- (SKEmitterNode *)spaceStarEmitterNodeWithBirthRate:(float)birthRate
                                               scale:(float)scale
                                            lifetime:(float)lifetime
                                               speed:(float)speed
                                               color:(SKColor *)color
                                     enableStarLight:(BOOL)enableStarLight
{
    SKTexture *starTexture = [SKTexture textureWithImageNamed:@"Star.png"];
    starTexture.filteringMode = SKTextureFilteringNearest;
    
    SKEmitterNode *emitterNode = [SKEmitterNode new];
    emitterNode.particleTexture = starTexture;
    emitterNode.particleBirthRate = IS_IPHONE ? birthRate : birthRate*2;
    emitterNode.particleScale = scale;
    emitterNode.particleLifetime = lifetime;
    emitterNode.particleSpeed = IS_IPHONE ? speed : speed*2;
    emitterNode.particleSpeedRange = ABS(emitterNode.particleSpeed/2);
    emitterNode.particleColor = color;
    
    emitterNode.particleColorBlendFactor = 1;
    emitterNode.position = CGPointMake((CGRectGetMidX(self.gameBounds)), CGRectGetMaxY(self.gameBounds));
    
    emitterNode.particlePositionRange = CGVectorMake(CGRectGetMaxX(self.gameBounds)*2, 0);
    [emitterNode advanceSimulationTime:lifetime];
    
    //setup star light
    if(enableStarLight) {
        float lightFluctuations = 15;
        SKKeyframeSequence * lightSequence = [[SKKeyframeSequence alloc] initWithCapacity:lightFluctuations *2];
        
        float lightTime = 1.0/lightFluctuations;
        for (int i = 0; i < lightFluctuations; i++) {
            [lightSequence addKeyframeValue:[SKColor whiteColor] time:((i * 2) * lightTime / 2)];
            [lightSequence addKeyframeValue:[SKColor yellowColor] time:((i * 2 + 2) * lightTime / 2)];
        }
        
        emitterNode.particleColorSequence = lightSequence;
    }
    
    return emitterNode;
}

-(void)speedUp{
}

-(void) tilt:(double)x{
    self.farAwayNode.position = CGPointMake(self.farAwayNode.position.x - x, self.position.y);
    self.middleNode.position = CGPointMake(self.middleNode.position.x - x*2, self.position.y);
    self.closeNode.position = CGPointMake(self.closeNode.position.x - x*3, self.position.y);
}

@end
