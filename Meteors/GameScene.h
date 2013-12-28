//
//  MyScene.h
//  Meteors
//

//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "InputHandler.h"
#import "BackgroundNode.h"
#import "StartView.h"
#import "HighScoreView.h"
#import "Ship.h"

@interface GameScene : SKScene <InputDelegate, StartViewDelegate, HighscoreDelegate, ShipDelegate, SKPhysicsContactDelegate>

@property (nonatomic, strong) Ship *ship;
@property (nonatomic, strong) InputHandler *inputHandler;
@property (nonatomic, strong) BackgroundNode *background;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) BOOL gameRunning;
@property (nonatomic, assign) double originY;

@property (nonatomic, strong) StartView *startView;
@property (nonatomic, strong) HighScoreView *highscoreView;

@end
