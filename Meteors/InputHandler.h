//
//  InputHandler.h
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol InputDelegate <NSObject>

-(void)accelerometerUpdate:(CGFloat)x y:(CGFloat)y;

@end

@interface InputHandler : NSObject

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) id<InputDelegate> delegate;

-(id)initInputHandler;
-(void)update;

@end
