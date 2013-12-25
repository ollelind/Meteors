//
//  HighScoreView.h
//  Meteors
//
//  Created by Olle Lind on 22/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HighscoreDelegate <NSObject>

-(void)restartButtonPressed;

@end

@interface HighScoreView : UIView

- (IBAction)restartButtonPressed:(id)sender;
@property (weak, nonatomic) id<HighscoreDelegate> delegate;


@end
