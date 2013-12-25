//
//  HighScoreView.m
//  Meteors
//
//  Created by Olle Lind on 22/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "HighScoreView.h"

@implementation HighScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)restartButtonPressed:(id)sender {
    [self.delegate restartButtonPressed];
}
@end
