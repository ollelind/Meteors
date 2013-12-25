//
//  InputHandler.m
//  Meteors
//
//  Created by Olle Lind on 14/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "InputHandler.h"

#define degrees(x) (180 * x / M_PI)

@implementation InputHandler

-(id)initInputHandler{
    self = [self init];
    if(self){
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = (1/60);
        [self.motionManager startAccelerometerUpdates];
        
        /*[self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            if(error){
                NSLog(@"Error starting accelerometer: %@", error);
            }else{
                [self handleAccelerometerUpdate:accelerometerData.acceleration];
            }
        }];*/
        

    }
    return self;
}

-(void)update{
    CMAcceleration acceleration = self.motionManager.accelerometerData.acceleration;
    [self.delegate accelerometerUpdate:acceleration.x y:acceleration.y];
}

@end
