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

@interface HighScoreView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;

@property (nonatomic) int score;
- (IBAction)restartButtonPressed:(id)sender;
@property (weak, nonatomic) id<HighscoreDelegate> delegate;


@end
