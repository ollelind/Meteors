//
//  MyScene.m
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "GameScene.h"
#import "Ship.h"
#import "InputHandler.h"
#import "Meteor.h"
#import "MovingObject.h"
#import "StartView.h"
#import "HighscoreClient.h"

#define ACTION_KEY_SPAWN_METEORS @"spawn_meteors"
#define ACTION_KEY_INCREASE_SCORE @"increase_score"

#define Z_POSITION_HUD 1
#define ORIGIN_NOT_DEFINED 1337

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        // Game stuff
        self.inputHandler = [[InputHandler alloc] initInputHandler];
        self.inputHandler.delegate = self;
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        // Physics
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = PhysicsBorders;
        
        // Background layer
        self.background = [[BackgroundNode alloc]initWithBounds:self.frame];
        [self addChild:self.background];
        
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        if(IS_IPHONE){
            self.scoreLabel.fontSize = 20.0;
        }else{
            self.scoreLabel.fontSize = 30.0;
        }
        
        self.scoreLabel.text = @"Score: 0";
        self.scoreLabel.name = @"scoreNode";
        self.scoreLabel.fontName = @"Starjedi";
        self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.scoreLabel.position = CGPointMake(self.size.width - self.scoreLabel.frame.size.width - 30, self.frame.size.height/20);
        self.scoreLabel.zPosition = Z_POSITION_HUD;
        [self addChild:self.scoreLabel];
        
        // Game layer
        
        
        self.ship = [[Ship alloc]initWithPosition:CGPointMake(self.frame.size.width/2, 50)];
        self.ship.delegate = self;
        [self addChild:_ship];
        
        //[self showStartView];
        
        
    }
    return self;
}

/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
}*/

-(void)update:(CFTimeInterval)currentTime {
    [self.inputHandler update];
}

-(void)increaseScore{
    self.score++;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.score];
}

#pragma mark -
#pragma mark Game states

-(void)didMoveToView:(SKView *)view{
    [self showStartView];
}
-(void)showStartView{
    NSArray* startScreenViews = [[NSBundle mainBundle] loadNibNamed:@"StartView" owner:self options:nil];
    self.startView = startScreenViews[0];
    self.startView.frame = self.frame;
    self.startView.delegate = self;
    [self.view addSubview:self.startView];
    [self showView:self.startView];
}
-(void)showHighscoreView{
    NSArray* highScoreViews = [[NSBundle mainBundle] loadNibNamed:@"HighScoreView" owner:self options:nil];
    self.highscoreView = highScoreViews[0];
    self.highscoreView.frame = self.frame;
    self.highscoreView.delegate = self;
    self.highscoreView.score = self.score;
    [self.view addSubview:self.highscoreView];

    [self showView:self.highscoreView];
    self.scoreLabel.hidden = YES;
}
-(void)startGamePressed{
    
    [self hideView:self.startView];
    
    SKAction *positionShip = [SKAction moveTo:CGPointMake(self.frame.size.width/2, self.frame.size.height/5) duration:50.0];
    positionShip.timingMode = SKActionTimingEaseOut;
    SKAction *startGameAction = [SKAction performSelector:@selector(startGame) onTarget:self];
    [self.ship runAction:[SKAction sequence:@[positionShip, startGameAction]]];
}

-(void)startGame{
    self.gameRunning = YES;
    self.score = 0;
    self.scoreLabel.hidden = NO;
    self.originY = ORIGIN_NOT_DEFINED;
    [self initMeteors];
    
    SKAction *increaseScore = [SKAction performSelector:@selector(increaseScore) onTarget:self];
    SKAction *waitAction = [SKAction waitForDuration:1];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[increaseScore, waitAction]]] withKey:ACTION_KEY_INCREASE_SCORE];
}

-(void)restartButtonPressed{
    [self removeActionForKey:ACTION_KEY_SPAWN_METEORS];
    
    [self hideView:self.highscoreView];
    
    self.ship = [[Ship alloc]initWithPosition:CGPointMake(self.frame.size.width/2, 50)];
    self.ship.delegate = self;
    [self.ship setScale:0.1];
    [self addChild:_ship];
    
    SKAction *positionShip = [SKAction moveTo:CGPointMake(self.frame.size.width/2, self.frame.size.height/5) duration:50.0];
    positionShip.timingMode = SKActionTimingEaseOut;
    SKAction *scaleAction;
    if(IS_IPHONE){
        scaleAction = [SKAction scaleTo:0.5 duration:50];
    }else{
        scaleAction = [SKAction scaleTo:1 duration:50];
    }
    scaleAction.timingMode = SKActionTimingEaseOut;
    SKAction *initShipAction = [SKAction group:@[positionShip, scaleAction]];
    
    
    SKAction *startGameAction = [SKAction performSelector:@selector(startGame) onTarget:self];
    [self.ship runAction:[SKAction sequence:@[initShipAction, startGameAction]]];
}

-(void)shipDestroyed{
    if(self.gameRunning){
        [self removeActionForKey:ACTION_KEY_INCREASE_SCORE];
        self.gameRunning = NO;
        [self.ship removeFromParent];
        [[HighscoreClient sharedClient] writeToLocalHighscore:self.score];
        [self showHighscoreView];
    }
}

#pragma mark -
#pragma mark View handlers
-(void)hideView:(UIView *)view{
    [UIView animateWithDuration:0.07
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
                                          } completion:^(BOOL finished) {
                                              [view removeFromSuperview];
                                          }];
                     }];
}

-(void)showView:(UIView *)view{
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.07
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                          } completion:nil];
                     }];
}

#pragma mark -
#pragma mark Spawn objects

-(void)initMeteors{
    SKAction *spawnAction = [SKAction performSelector:@selector(spawnMeteor) onTarget:self];
    SKAction *waitAction1 = [SKAction waitForDuration:0.2 withRange:0];

    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[spawnAction, waitAction1]]] withKey:ACTION_KEY_SPAWN_METEORS];
}
-(void)spawnMeteor{
    CGFloat xPos = arc4random() % (int)self.frame.size.width;
    Meteor *meteor = [[Meteor alloc]initWithPosition:CGPointMake(xPos, self.frame.size.height)];
    SKAction *moveAction = [SKAction moveToY:-100 duration:50];
    SKAction *rotateAction = [SKAction rotateByAngle:M_PI_4 / 4 duration:1.5];
    SKAction *moveGroup = [SKAction group:@[moveAction, [SKAction repeatAction:rotateAction count:50]]];
    SKAction *removeAction = [SKAction removeFromParent];
    
    [meteor runAction:[SKAction sequence:@[moveGroup, removeAction]]];
    [self addChild:meteor];
}

#pragma mark -
#pragma mark Physics Delegate

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    
        SKNode *contactNode = contact.bodyA.node;
        if([contactNode isKindOfClass:[MovingObject class]]) {
            [(MovingObject *)contactNode collidedWith:contact.bodyB contact:contact];
        }
        contactNode = contact.bodyB.node;
        if([contactNode isKindOfClass:[MovingObject class]]) {
            [(MovingObject *)contactNode collidedWith:contact.bodyA contact:contact];
        }
    [self.background speedUp];
}

#pragma mark -
#pragma mark InputDelegate

-(void)accelerometerUpdate:(CGFloat)x y:(CGFloat)y{
    if(_originY == ORIGIN_NOT_DEFINED){
        self.originY = y;
    }
    if(self.gameRunning){
        [self.background tilt:x];
        [self.ship move:x y:y];
    }
}

@end
