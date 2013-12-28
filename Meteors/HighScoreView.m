//
//  HighScoreView.m
//  Meteors
//
//  Created by Olle Lind on 22/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "HighScoreView.h"
#import "HighscoreClient.h"

@implementation HighScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    int titleSize = IS_IPHONE ? 45 : 90;
    self.titleLabel.font = [UIFont fontWithName:@"Starjedi" size:titleSize];
    self.restartButton.titleLabel.font = [UIFont fontWithName:@"Starjedi" size:titleSize];
    
    self.nameTextfield.delegate = self;
    self.nameTextfield.font = [UIFont fontWithName:@"Starjedi" size:25];
    self.nameTextfield.text = @"NAME";
    
    NSArray *localHighscores = [[HighscoreClient sharedClient] readLocalHighscores];
    int highscoreSize = IS_IPHONE ? 25 : 50;
    for(int i=0; i<localHighscores.count; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - 100, CGRectGetMaxY(self.titleLabel.frame) + 120 + i*highscoreSize, 200, highscoreSize)];
        label.text = [NSString stringWithFormat:@"%d: %@", i+1, localHighscores[i]];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Starjedi" size:highscoreSize];
        [self addSubview:label];
    }
}

-(void)setScore:(int)score{
    _score = score;
    self.titleLabel.text = [NSString stringWithFormat:@"Score: %d", self.score];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.nameTextfield.text = @"";
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameTextfield resignFirstResponder];
    return YES;
}

- (IBAction)restartButtonPressed:(id)sender {
    [self.delegate restartButtonPressed];
}
@end
